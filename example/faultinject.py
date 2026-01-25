# run test with -> python3 faultinject.py <binary> <num_runs> "<input_args>"
#!/usr/bin/python

import sys
import os
import time
import subprocess
import summarize_results

# =============================================================
# Paths
# =============================================================
currdir = "/home/rmengle/pin/source/tools/pinfi/example"

execdir = os.path.join(currdir, "basicmath_small_executables")

pinbin = "/home/rmengle/pin/pin"
instcountlib = "/home/rmengle/pin/source/tools/pinfi/obj-intel64/instcount.so"
filib = "/home/rmengle/pin/source/tools/pinfi/obj-intel64/faultinjection.so"

basedir = os.path.join(currdir, "baseline")
errordir = os.path.join(currdir, "error_output")

program_outputs_root = os.path.join(currdir, "program_outputs")
execution_times_root = os.path.join(currdir, "execution_times")

# =============================================================
# Ensure base directories exist
# =============================================================
for d in [basedir, errordir, program_outputs_root, execution_times_root]:
    os.makedirs(d, exist_ok=True)

timeout = 500

# =============================================================
# Execute one run
# =============================================================
def execute(execlist, outputfile, run_index):
    timeout_local = 30

    with open(outputfile, "w") as outputFile:
        p = subprocess.Popen(
            execlist,
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
            universal_newlines=False
        )

        start_time = time.time()

        for raw in p.stdout:
            line = raw.decode("utf-8", errors="replace").rstrip()
            outputFile.write(line + "\n")
            outputFile.flush()

            if time.time() - start_time > timeout_local:
                p.kill()
                return "timed-out", None

        returncode = p.wait()
        elapsed = round(time.time() - start_time, 6)

    return str(returncode), elapsed

# =============================================================
# Main logic
# =============================================================
def main(progbin, binary_name, run_number, optionlist):
    program_outputs_dir = os.path.join(program_outputs_root, binary_name)
    execution_times_dir = os.path.join(
        execution_times_root, f"{binary_name}_times"
    )

    os.makedirs(program_outputs_dir, exist_ok=True)
    os.makedirs(execution_times_dir, exist_ok=True)

    for index in range(run_number):
        print(f"Run Number: #{index + 1}")

        outputfile = os.path.join(
            program_outputs_dir,
            f"output_run_{index}.txt"
        )

        timefile = os.path.join(
            execution_times_dir,
            f"time_run_{index}.txt"
        )

        execlist = [
            pinbin,
            "-t", filib,
            "-fioption", "AllInst",
            "--", progbin
        ]
        execlist.extend(optionlist)

        ret, elapsed = execute(execlist, outputfile, index)

        if ret == "timed-out":
            with open(os.path.join(errordir, f"error_run_{index}.txt"), "w") as f:
                f.write("Program hang\n")
            continue

        if elapsed is not None:
            with open(timefile, "w") as f:
                f.write(f"{elapsed}\n")

        if int(ret) != 0:
            with open(os.path.join(errordir, f"error_run_{index}.txt"), "w") as f:
                f.write(f"Program exited with code {ret}\n")

# =============================================================
# Entry point
# =============================================================
if __name__ == "__main__":
    assert len(sys.argv) == 4, (
        "Usage: python3 faultinject.py <binary> <num_runs> \"<input_args>\""
    )

    binary_name = os.path.basename(sys.argv[1])
    progbin = os.path.join(execdir, binary_name)

    if not os.path.isfile(progbin):
        raise FileNotFoundError(f"Executable not found: {progbin}")

    run_number = int(sys.argv[2])
    optionlist = sys.argv[3].split(" ") if sys.argv[3] else []

    print("DEBUG: Running", progbin)

    main(progbin, binary_name, run_number, optionlist)