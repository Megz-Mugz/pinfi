#!/usr/bin/python3

import sys
import os
import subprocess

# run test with -> python3 faultinject.py <binary> <num_runs> "<input_args>"

currdir = "/home/rmengle/pin/source/tools/pinfi/example"

# TODO if you change this, change the EXEC_DIR line on submit_mass_jobs.sh
focus_dir = "paired_executables/qsort_small/execs/leader-loop-unroll"

execdir = os.path.join(currdir, focus_dir)

IS_PATRICIA = "patricia" in focus_dir.lower()
EXPECTED_EXIT_CODES = [0, 1] if IS_PATRICIA else [0]

pinbin = "/home/rmengle/pin/pin"
instcountlib = "/home/rmengle/pin/source/tools/pinfi/obj-intel64/instcount.so"
filib = "/home/rmengle/pin/source/tools/pinfi/obj-intel64/faultinjection.so"

program_outputs_root = "/projects/lyang28/rmengle"

errordir = os.path.join(currdir, "error_output")

os.makedirs(program_outputs_root, exist_ok=True)
os.makedirs(errordir, exist_ok=True)

TIMEOUT_SECONDS = 15


def run_command(cmd, outputfile, cwd):
    p = None

    try:
        p = subprocess.Popen(
            cmd,
            cwd=cwd,
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
            universal_newlines=False
        )

        out, _ = p.communicate(timeout=TIMEOUT_SECONDS)

        with open(outputfile, "w", encoding="utf-8", errors="replace") as f:
            if out:
                f.write(out.decode("utf-8", errors="replace"))

        return str(p.returncode)

    except subprocess.TimeoutExpired:
        if p is not None:
            p.kill()

            try:
                out, _ = p.communicate(timeout=2)
            except Exception:
                out = b""
        else:
            out = b""

        with open(outputfile, "w", encoding="utf-8", errors="replace") as f:
            if out:
                f.write(out.decode("utf-8", errors="replace"))

            f.write("\n[TIMEOUT]\n")

        return "timed-out"

    except Exception as e:
        with open(outputfile, "w", encoding="utf-8", errors="replace") as f:
            f.write("[RUN COMMAND ERROR]\n")
            f.write(f"{type(e).__name__}: {e}\n")

        return "command-error"


def main(progbin, binary_name, run_number, optionlist):
    program_outputs_dir = os.path.join(
        program_outputs_root,
        binary_name
    )

    os.makedirs(program_outputs_dir, exist_ok=True)

    if IS_PATRICIA:
        run_cwd = execdir
        instcount_file = os.path.join(execdir, "pin.instcount.txt")
        saved_instcount_file = os.path.join(program_outputs_dir, "pin.instcount.txt")
    else:
        run_cwd = program_outputs_dir
        instcount_file = os.path.join(program_outputs_dir, "pin.instcount.txt")
        saved_instcount_file = instcount_file

    if os.path.exists(instcount_file):
        os.remove(instcount_file)

    if IS_PATRICIA and os.path.exists(saved_instcount_file):
        os.remove(saved_instcount_file)

    instcount_cmd = [
        pinbin,
        "-t", instcountlib,
        "-o", "pin.instcount.txt",
        "--", progbin
    ]
    instcount_cmd.extend(optionlist)

    print("DEBUG INSTCOUNT:", " ".join(instcount_cmd))
    print("DEBUG CWD:", run_cwd)

    ret = run_command(
        instcount_cmd,
        os.path.join(program_outputs_dir, "instcount_output.txt"),
        run_cwd
    )

    if ret == "timed-out":
        raise RuntimeError("instcount timed out")

    if ret == "command-error":
        raise RuntimeError("instcount command failed")

    if int(ret) not in EXPECTED_EXIT_CODES:
        raise RuntimeError(f"instcount failed with code {ret}")

    if not os.path.isfile(instcount_file):
        raise RuntimeError(f"pin.instcount.txt was not created at {instcount_file}")

    if IS_PATRICIA:
        with open(instcount_file, "rb") as src:
            with open(saved_instcount_file, "wb") as dst:
                dst.write(src.read())

    print(f"DEBUG: Created {instcount_file}")

    if IS_PATRICIA:
        print(f"DEBUG: Saved copy to {saved_instcount_file}")

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
        print("DEBUG CWD:", run_cwd)

        ret = run_command(
            execlist,
            outputfile,
            run_cwd
        )

        if ret == "timed-out":
            with open(os.path.join(errordir, f"error_run_{index}.txt"), "w") as f:
                f.write("Program hang\n")
            continue

        if ret == "command-error":
            with open(os.path.join(errordir, f"error_run_{index}.txt"), "w") as f:
                f.write("Fault injection command failed before completion\n")
            continue

        if int(ret) not in EXPECTED_EXIT_CODES:
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