#!/usr/bin/python
# run with -> python3 compilation.py <program_name> <program_directory> "<base compilation args>"

from typing import List, Tuple
import sys
import os
import shutil
from datetime import datetime

import config
from run_command import run_command

#########
# Paths #
#########
curr_file = os.path.abspath(__file__)
curr_dir = os.path.dirname(curr_file)

clang_bin = shutil.which("clang")
linker_bin = shutil.which("llvm-link")
optimizer_bin = shutil.which("opt")

# output directory structure:
# paired_executables
# |- program_name
#   |- execs
#   |- bc
#   |- logs

binaries_root = os.path.join(curr_dir, "paired_executables")

#############
# Constants #
#############

basic_optimizations = ["O0", "O1", "O2", "O3"]

optimizations = [
    ("licm", "loop-mssa"),
    ("instcombine", "function"),
    ("early-cse", "function"),
    ("gvn", "function"),
    ("ipsccp", "module"),
    ("inline", "cgscc"),
    ("loop-reduce", "loop"),
    ("loop-unroll", "function"),
    ("simple-loop-unswitch", "loop"),
    ("sccp", "function"),
]

source_suffixes = ["c", "cpp"]

#############
# Logging   #
#############

def log(msg: str):
    now = datetime.now().strftime("%H:%M:%S")
    print(f"[{now}] {msg}")

def log_section(title: str):
    print("\n" + "=" * 80)
    print(title)
    print("=" * 80)

#############
# Helpers   #
#############

def get_source_names(command: List[str]) -> List[str]:
    source_files = []
    for arg in command:
        for suffix in source_suffixes:
            if arg.endswith("." + suffix):
                source_files.append(os.path.splitext(arg)[0])
                break
    return source_files


def get_link_lib_args(command: List[str]) -> List[str]:
    link_lib_args = []
    for arg in command:
        if arg.startswith("-l"):
            link_lib_args.append(arg)
    return link_lib_args


def are_llvm_tools_available() -> bool:
    return (
        clang_bin is not None
        and linker_bin is not None
        and optimizer_bin is not None
        and os.access(clang_bin, os.X_OK)
        and os.access(linker_bin, os.X_OK)
        and os.access(optimizer_bin, os.X_OK)
    )


def ensure_dir(path: str):
    os.makedirs(path, exist_ok=True)


#############
# Pass logic #
#############

def pass_type_compare_gt(a: str, b: str):
    pass_map = {
        "loop": 0,
        "loop-mssa": 0,
        "function": 1,
        "cgscc": 2,
        "module": 3,
    }

    if a not in pass_map:
        raise RuntimeError(f"bad pass type: {a}")
    if b not in pass_map:
        raise RuntimeError(f"bad pass type: {b}")

    return pass_map[a] > pass_map[b]


def pass_type_is_incompatible_loop(a: str, b: str):
    return (a == "loop" and b == "loop-mssa") or (a == "loop-mssa" and b == "loop")


def lower_type(pass_type: str, prefer_mssa: bool = False):
    if pass_type == "module":
        return "cgscc"
    if pass_type == "cgscc":
        return "function"
    if pass_type == "function":
        return "loop-mssa" if prefer_mssa else "loop"
    raise RuntimeError(f"bad pass type to lower: {pass_type}")


def raise_type(pass_type: str):
    if pass_type == "loop":
        return "function"
    if pass_type == "loop-mssa":
        return "function"
    if pass_type == "function":
        return "cgscc"
    if pass_type == "cgscc":
        return "module"
    raise RuntimeError(f"bad pass type to raise: {pass_type}")


def max_pass_type(optimizations: List[Tuple[str, str]]):
    types = [opt[1] for opt in optimizations]

    max_type = "function"
    for pass_type in types:
        if pass_type_compare_gt(pass_type, max_type):
            max_type = pass_type
    return max_type


def generate_pass_string(optimizations: List[Tuple[str, str]]):
    max_type = max_pass_type(optimizations)

    curr_str = max_type + "("
    curr_type = max_type
    is_first_of_type = True

    for optimization in optimizations:
        pass_name = optimization[0]
        pass_type = optimization[1]
        is_loop_mssa = pass_type == "loop-mssa"

        while pass_type_compare_gt(curr_type, pass_type):
            if not is_first_of_type:
                curr_str += ","
            curr_type = lower_type(curr_type, is_loop_mssa)
            curr_str += curr_type + "("
            is_first_of_type = True

        while pass_type_compare_gt(pass_type, curr_type):
            curr_str += ")"
            curr_type = raise_type(curr_type)
            is_first_of_type = False

        if pass_type_is_incompatible_loop(pass_type, curr_type):
            curr_type = pass_type
            curr_str += ")," + curr_type + "("
            is_first_of_type = True

        if not is_first_of_type:
            curr_str += ","
        else:
            is_first_of_type = False

        curr_str += pass_name

    while pass_type_compare_gt(max_type, curr_type):
        curr_str += ")"
        curr_type = raise_type(curr_type)

    curr_str += ")"
    return curr_str


#####################
# Compilation stages #
#####################

def compile_default(program_name: str,
                    exec_dir: str,
                    log_dir: str,
                    base_compiler_args: List[str]):

    log_section("STAGE 1: COMPILING DEFAULT OPTIMIZATION LEVELS")

    compiler_command_base = [clang_bin] + base_compiler_args

    for basic in basic_optimizations:
        log(f"Compiling default build: {basic}")

        output_file = os.path.join(exec_dir, f"exec_{program_name}_{basic}")
        compiler_output_file = os.path.join(log_dir, f"compiler_output_{basic}.txt")
        compiler_args = ["-" + basic, "-o", output_file]

        run_command(compiler_command_base, compiler_args, compiler_output_file)

        if os.path.isfile(output_file):
            log(f"Created executable: {output_file}")
        else:
            log(f"WARNING: Expected executable missing: {output_file}")


def compile_bitcode(program_name: str,
                    bc_dir: str,
                    log_dir: str,
                    base_compiler_args: List[str]):

    log_section("STAGE 2: EXTRACTING UNOPTIMIZED BITCODE")

    compiler_command_base = [clang_bin] + base_compiler_args
    compiler_output_file = os.path.join(log_dir, "compiler_output_bitcode.txt")
    compiler_args = [
        "-emit-llvm",
        "-c",
        "-O0",
        "-Xclang",
        "-disable-O0-optnone",
    ]

    log("Extracting .bc files from source translation units")
    run_command(compiler_command_base, compiler_args, compiler_output_file)

    source_names = get_source_names(base_compiler_args)

    for name in source_names:
        src_bc = f"{name}.bc"
        dst_bc = os.path.join(bc_dir, f"bc_{name}.bc")

        if not os.path.isfile(src_bc):
            raise FileNotFoundError(f"Expected bitcode file not found: {src_bc}")

        shutil.move(src_bc, dst_bc)
        log(f"Moved bitcode: {src_bc} -> {dst_bc}")


def compile_optimized(program_name: str,
                      exec_dir: str,
                      bc_dir: str,
                      log_dir: str,
                      base_bitcode_names: List[str],
                      link_lib_args: List[str],
                      optimizations_to_apply: List[Tuple[str, str]]):

    opt_names = [opt[0] for opt in optimizations_to_apply]
    suffix = "_".join(opt_names)
    passes = generate_pass_string(optimizations_to_apply)

    log_section(f"OPTIMIZATION PIPELINE: {suffix}")
    log(f"Pass pipeline: {passes}")

    os.chdir(bc_dir)

    optimizer_command_base = [optimizer_bin, f"-passes={passes}"]
    output_file_names = [f"{name}_{suffix}.bc" for name in base_bitcode_names]

    for name in base_bitcode_names:
        input_bc = name + ".bc"
        output_bc = f"{name}_{suffix}.bc"
        optimizer_args = [input_bc, "-o", output_bc]
        optimizer_output_file = os.path.join(log_dir, f"optimizer_output_{name}_{suffix}.txt")

        log(f"Running opt on {input_bc} -> {output_bc}")
        run_command(optimizer_command_base, optimizer_args, optimizer_output_file)

        if os.path.isfile(output_bc):
            log(f"Created optimized bitcode: {os.path.join(bc_dir, output_bc)}")
        else:
            log(f"WARNING: Expected optimized bitcode missing: {os.path.join(bc_dir, output_bc)}")

    linked_file_name = f"bc_{program_name}_{suffix}_linked.bc"
    linker_command_base = [linker_bin] + output_file_names
    linker_args = ["-o", linked_file_name]
    linker_output_file = os.path.join(log_dir, f"linker_output_{program_name}_{suffix}.txt")

    log(f"Linking optimized bitcode files -> {linked_file_name}")
    run_command(linker_command_base, linker_args, linker_output_file)

    linked_file_path = os.path.join(bc_dir, linked_file_name)
    if os.path.isfile(linked_file_name):
        log(f"Created linked bitcode: {linked_file_path}")
    else:
        log(f"WARNING: Expected linked bitcode missing: {linked_file_path}")

    output_file = os.path.join(exec_dir, f"exec_{program_name}_{suffix}")
    compiler_command_base = [clang_bin, linked_file_name]
    compiler_args = ["-o", output_file] + link_lib_args
    compiler_output_file = os.path.join(log_dir, f"compiler_output_{suffix}.txt")

    log(f"Compiling executable -> {output_file}")
    run_command(compiler_command_base, compiler_args, compiler_output_file)

    if os.path.isfile(output_file):
        log(f"Created executable: {output_file}")
    else:
        log(f"WARNING: Expected executable missing: {output_file}")


def compile_singles(program_name: str,
                    exec_dir: str,
                    bc_dir: str,
                    log_dir: str,
                    base_bitcode_names: List[str],
                    link_lib_args: List[str]):

    log_section("STAGE 3: COMPILING SINGLE-OPTIMIZATION VARIANTS")

    for single in optimizations:
        compile_optimized(
            program_name,
            exec_dir,
            bc_dir,
            log_dir,
            base_bitcode_names,
            link_lib_args,
            [single]
        )


def compile_doubles(program_name: str,
                    exec_dir: str,
                    bc_dir: str,
                    log_dir: str,
                    base_bitcode_names: List[str],
                    link_lib_args: List[str]):

    log_section("STAGE 4: COMPILING PAIRED-OPTIMIZATION VARIANTS")

    for opt_a in optimizations:
        for opt_b in optimizations:
            compile_optimized(
                program_name,
                exec_dir,
                bc_dir,
                log_dir,
                base_bitcode_names,
                link_lib_args,
                [opt_a, opt_b]
            )


def compile_all(program_name: str,
                exec_dir: str,
                bc_dir: str,
                log_dir: str,
                base_compiler_args: List[str]):

    compile_default(program_name, exec_dir, log_dir, base_compiler_args)
    compile_bitcode(program_name, bc_dir, log_dir, base_compiler_args)

    source_names = get_source_names(base_compiler_args)
    base_bitcode_names = ["bc_" + name for name in source_names]
    link_lib_args = get_link_lib_args(base_compiler_args)

    compile_singles(
        program_name,
        exec_dir,
        bc_dir,
        log_dir,
        base_bitcode_names,
        link_lib_args
    )

    compile_doubles(
        program_name,
        exec_dir,
        bc_dir,
        log_dir,
        base_bitcode_names,
        link_lib_args
    )


#############
# Validation #
#############

def check_all(program_name: str, exec_dir: str):
    version_names = []
    version_names += basic_optimizations

    opt_names = [opt[0] for opt in optimizations]
    version_names += opt_names

    for a in opt_names:
        for b in opt_names:
            version_names.append(f"{a}_{b}")

    exec_names = [
        os.path.join(exec_dir, "exec_" + program_name + "_" + version_name)
        for version_name in version_names
    ]

    missing_count = 0
    for exec_name in exec_names:
        if not os.path.isfile(exec_name):
            log(f"MISSING executable: {exec_name}")
            missing_count += 1

    return missing_count


########
# Main #
########

def main(program_name: str,
         program_directory: str,
         base_compiler_args: List[str]):

    log_section("COMPILATION DRIVER START")

    log(f"Program name: {program_name}")
    log(f"Program directory argument: {program_directory}")
    log(f"Current working directory: {os.getcwd()}")
    log(f"Script directory: {curr_dir}")
    log(f"clang: {clang_bin}")
    log(f"llvm-link: {linker_bin}")
    log(f"opt: {optimizer_bin}")

    if not are_llvm_tools_available():
        print("Error: missing LLVM tools")
        print(f"clang: {clang_bin}")
        print(f"llvm-link: {linker_bin}")
        print(f"opt: {optimizer_bin}")
        return

    if not os.path.isdir(program_directory):
        print(f"Error: program directory does not exist: {program_directory}")
        print(f"Current working directory: {os.getcwd()}")
        return

    binary_dir = os.path.join(binaries_root, program_name)
    exec_dir = os.path.join(binary_dir, "execs")
    bc_dir = os.path.join(binary_dir, "bc")
    log_dir = os.path.join(binary_dir, "logs")

    ensure_dir(binaries_root)
    ensure_dir(binary_dir)
    ensure_dir(exec_dir)
    ensure_dir(bc_dir)
    ensure_dir(log_dir)

    log(f"Output root: {binary_dir}")
    log(f"Executables directory: {exec_dir}")
    log(f"Bitcode directory: {bc_dir}")
    log(f"Logs directory: {log_dir}")

    os.chdir(program_directory)
    log(f"Changed working directory to source directory: {os.getcwd()}")

    compile_all(
        program_name,
        exec_dir,
        bc_dir,
        log_dir,
        base_compiler_args
    )

    log_section("FINAL VERIFICATION")
    missing_count = check_all(program_name, exec_dir)

    if missing_count == 0:
        log("All executables compiled successfully")
    else:
        log(f"Compilation finished with {missing_count} missing executables")

    log_section("COMPILATION DRIVER END")


def printUsage():
    print('Usage: python3 compilation.py <program_name> <program_directory> "<base compilation args>"')
    print("\tprogram_name: the name of the program, used to name output")
    print("\tprogram_directory: the directory in which to invoke the compiler")
    print("\tbase compilation args: all args to pass to the compiler other than the name of the compiler, the output file, and the optimizations")


if __name__ == "__main__":
    if len(sys.argv) != 4:
        printUsage()
        sys.exit(0)

    program_name = sys.argv[1]
    program_directory = sys.argv[2]
    base_compiler_args = sys.argv[3].split(" ")

    main(
        program_name,
        program_directory,
        base_compiler_args
    )