import os
import statistics
import csv

# =============================================================
# Configuration
# =============================================================

CURRDIR = "/home/rmengle/pin/source/tools/pinfi/example"

''''
TODO: IF YOU CHANGE HERE, CHANGE OTHER TODOS IN classify_output.py & slum
'''
focus_directory = "benchmarks/basicmath/basicmath_large_executables"
csv_name = focus_directory.split('/')[-1] + "_data"


EXECUTABLES_DIR = os.path.join(
    CURRDIR,
    focus_directory
)

GOLDEN_FILE = "baseline/golden_std_output"
PROGRAM_OUTPUTS_ROOT = "program_outputs"
EXECUTION_TIMES_ROOT = "execution_times"
CSV_OUTPUT_FILE = csv_name + ".csv"

# =============================================================
# Discover executables dynamically
# =============================================================

def discover_executables(exec_dir):
    if not os.path.isdir(exec_dir):
        raise FileNotFoundError(
            f"Executable directory not found: {exec_dir}"
        )

    bins = []

    for fname in sorted(os.listdir(exec_dir)):
        full_path = os.path.join(exec_dir, fname)

        if os.path.isfile(full_path) and fname.endswith("_exec"):
            bins.append(fname)

    if not bins:
        raise RuntimeError("No executables found in directory.")

    return bins


EXECUTABLES = discover_executables(EXECUTABLES_DIR)

print("Discovered executables:")
i = 1
for b in EXECUTABLES:
    print(f" {i}.  {b}")
    i += 1
print()

# =============================================================
# Helpers
# =============================================================

def load_file(path):
    try:
        with open(path, "r") as f:
            return f.read().strip()
    except Exception:
        return None


golden_output = load_file(GOLDEN_FILE)

if golden_output is None:
    raise RuntimeError("Golden output not found or unreadable.")

# =============================================================
# Classification
# =============================================================

def classify_outputs(binary_name):

    output_dir = os.path.join(
        PROGRAM_OUTPUTS_ROOT,
        binary_name
    )

    if not os.path.isdir(output_dir):
        return None

    masked = 0
    sdc = 0
    crash_or_hang = 0
    total_runs = 0

    for fname in os.listdir(output_dir):
        full_path = os.path.join(output_dir, fname)

        if not os.path.isfile(full_path):
            continue

        try:
            with open(full_path, "r") as f:
                contents = f.read().strip()
                total_runs += 1

                if not any(char.isdigit() for char in contents):
                    crash_or_hang += 1
                elif contents == golden_output:
                    masked += 1
                else:
                    sdc += 1

        except Exception:
            continue

    return total_runs, masked, sdc, crash_or_hang

# =============================================================
# Timing statistics
# =============================================================

def get_execution_time_stats(binary_name):

    timing_file = os.path.join(
        EXECUTION_TIMES_ROOT,
        f"{binary_name}.txt"
    )

    if not os.path.isfile(timing_file):
        return None, None

    times = []

    try:
        with open(timing_file, "r") as f:
            for line in f:
                line = line.strip()
                if not line:
                    continue
                try:
                    times.append(float(line))
                except ValueError:
                    continue
    except Exception:
        return None, None

    if not times:
        return None, None

    return (
        sum(times) / len(times),
        statistics.median(times)
    )

# =============================================================
# Main CSV generation
# =============================================================

if __name__ == "__main__":

    total_bins = len(EXECUTABLES)

    with open(CSV_OUTPUT_FILE, "w", newline="") as csvfile:

        writer = csv.writer(csvfile)

        # -----------------------------------------------------
        # CSV Header
        # -----------------------------------------------------
        writer.writerow([
            "executable",
            "total_runs",
            "masked",
            "sdc",
            "crash_hang",
            "avg_time",
            "median_time",
        ])

        # -----------------------------------------------------
        # Process each binary
        # -----------------------------------------------------
        for idx, binary in enumerate(EXECUTABLES, start=1):

            print(f"[{idx:2d}/{total_bins}] Processing {binary}")

            classification = classify_outputs(binary)

            if classification is None:
                print(f"   [WARN] Missing outputs for {binary}")
                writer.writerow([binary, "", "", "", "", "", ""])
                continue

            total_runs, masked, sdc, crash_or_hang = classification

            avg_time, median_time = \
                get_execution_time_stats(binary)

            writer.writerow([
                binary,
                total_runs,
                masked,
                sdc,
                crash_or_hang,
                f"{avg_time:.6f}" if avg_time is not None else "",
                f"{median_time:.6f}" if median_time is not None else "",
            ])

    print(f"\nCSV written to: {CSV_OUTPUT_FILE}\n")