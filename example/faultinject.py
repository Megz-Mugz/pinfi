#!/usr/bin/python3

import sys
import os
import subprocess

# run test with -> python3 faultinject.py <binary> <num_runs> "<input_args>"

currdir = "/home/rmengle/pin/source/tools/pinfi/example"

focus_dir = "paired_executables/basicmath_small/execs/leader-gvn"

execdir = os.path.join(currdir, focus_dir)

pinbin = "/home/rmengle/pin/pin"
instcountlib = "/home/rmengle/pin/source/tools/pinfi/obj-intel64/instcount.so"
filib = "/home/rmengle/pin/source/tools/pinfi/obj-intel64/faultinjection.so"

program_outputs_root = "/projects/lyang28/rmengle"

errordir = os.path.join(currdir, "error_output")

os.makedirs(program_outputs_root, exist_ok=True)
os.makedirs(errordir, exist_ok=True)

TIMEOUT_SECONDS = 15


def run_command(cmd, outputfile, cwd):
    with open(outputfile, "w") as f:
        try:
            p = subprocess.Popen(
                cmd,
                cwd=cwd,
                stdout=subprocess.PIPE,
                stderr=subprocess.STDOUT,
                universal_newlines=True
            )

            out, _ = p.communicate(timeout=TIMEOUT_SECONDS)

            if out:
                f.write(out)

            return str(p.returncode)

        except subprocess.TimeoutExpired:
            p.kill()
            f.write("[TIMEOUT]\n")
            return "timed-out"


def main(progbin, binary_name, run_number, optionlist):
    program_outputs_dir = os.path.join(
        program_outputs_root,
        binary_name
    )

    os.makedirs(program_outputs_dir, exist_ok=True)

    # IMPORTANT:
    # faultinjection.so looks for pin.instcount.txt in its current working directory.
    # So generate it inside program_outputs_dir, then run FI from that same dir.
    instcount_file = os.path.join(program_outputs_dir, "pin.instcount.txt")

    if os.path.exists(instcount_file):
        os.remove(instcount_file)

    instcount_cmd = [
        pinbin,
        "-t", instcountlib,
        "-o", "pin.instcount.txt",
        "--", progbin
    ]
    instcount_cmd.extend(optionlist)

    print("DEBUG INSTCOUNT:", " ".join(instcount_cmd))

    ret = run_command(
        instcount_cmd,
        os.path.join(program_outputs_dir, "instcount_output.txt"),
        program_outputs_dir
    )

    if ret == "timed-out":
        raise RuntimeError("instcount timed out")

    if int(ret) != 0:
        raise RuntimeError(f"instcount failed with code {ret}")

    if not os.path.isfile(instcount_file):
        raise RuntimeError(f"pin.instcount.txt was not created at {instcount_file}")

    print(f"DEBUG: Created {instcount_file}")

    for index in range(run_number):
        print(f"Run Number: #{index + 1}")

        outputfile = os.path.join(
            program_outputs_dir,
            f"output_run_{index}.txt"
        )

        execlist = [
            pinbin,
            "-t", filib,
            "-fioption", "AllInst",
            "--", progbin
        ]
        execlist.extend(optionlist)

        print("DEBUG FI:", " ".join(execlist))

        ret = run_command(
            execlist,
            outputfile,
            program_outputs_dir
        )

        if ret == "timed-out":
            with open(os.path.join(errordir, f"error_run_{index}.txt"), "w") as f:
                f.write("Program hang\n")
            continue

        if int(ret) != 0:
            with open(os.path.join(errordir, f"error_run_{index}.txt"), "w") as f:
                f.write(f"Program exited with code {ret}\n")


if __name__ == "__main__":
    assert len(sys.argv) == 4, (
        'Usage: python3 faultinject.py <binary> <num_runs> "<input_args>"'
    )

    binary_name = os.path.basename(sys.argv[1])

    progbin = os.path.join(execdir, binary_name)

    if not os.path.isfile(progbin):
        raise FileNotFoundError(f"Executable not found: {progbin}")

    run_number = int(sys.argv[2])
    optionlist = sys.argv[3].split(" ") if sys.argv[3] else []

    print("DEBUG: Running", progbin)

    main(progbin, binary_name, run_number, optionlist)
