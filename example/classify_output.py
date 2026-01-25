import os
import statistics
import csv

# =============================================================
# Configuration
# =============================================================
GOLDEN_FILE = "baseline/golden_std_output"
PROGRAM_OUTPUTS_ROOT = "program_outputs"
EXECUTION_TIMES_ROOT = "execution_times"
CSV_OUTPUT_FILE = "pinfi_results.csv"

EXECUTABLES = [
    # O-levels (dynamic)
    "basicmath_O0_exec",
    "basicmath_O1_exec",
    "basicmath_O2_exec",
    "basicmath_O3_exec",

    # O-levels (static)
    "basicmath_O0_exec_static",
    "basicmath_O1_exec_static",
    "basicmath_O2_exec_static",
    "basicmath_O3_exec_static",

    # Pass-isolated (dynamic)
    "basicmath_licm_exec",
    "basicmath_instcombine_exec",
    "basicmath_cse_exec",
    "basicmath_gvn_exec",
    "basicmath_ipsccp_exec",
    "basicmath_inline_exec",
    "basicmath_loopreduce_exec",
    "basicmath_unroll_exec",
    "basicmath_unroll4_exec",
    "basicmath_unswitch_exec",
    "basicmath_sccp_exec",

    # Pass-isolated (static)
    "basicmath_licm_exec_static",
    "basicmath_instcombine_exec_static",
    "basicmath_cse_exec_static",
    "basicmath_gvn_exec_static",
    "basicmath_ipsccp_exec_static",
    "basicmath_inline_exec_static",
    "basicmath_loopreduce_exec_static",
    "basicmath_unroll_exec_static",
    "basicmath_unroll4_exec_static",
    "basicmath_unswitch_exec_static",
    "basicmath_sccp_exec_static",
]

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
    output_dir = os.path.join(PROGRAM_OUTPUTS_ROOT, binary_name)

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
    time_dir = os.path.join(
        EXECUTION_TIMES_ROOT,
        f"{binary_name}_times"
    )

    if not os.path.isdir(time_dir):
        return None, None

    times = []

    for fname in os.listdir(time_dir):
        full_path = os.path.join(time_dir, fname)

        if not os.path.isfile(full_path):
            continue

        try:
            with open(full_path, "r") as f:
                times.append(float(f.read().strip()))
        except Exception:
            continue

    if not times:
        return None, None

    return (
        sum(times) / len(times),
        statistics.median(times)
    )


# =============================================================
# Main CSV generation (WITH PROGRESS OUTPUT)
# =============================================================
if __name__ == "__main__":
    total_bins = len(EXECUTABLES)

    with open(CSV_OUTPUT_FILE, "w", newline="") as csvfile:
        writer = csv.writer(csvfile)

        # Header
        writer.writerow([
            "executable",
            "total_runs",
            "masked",
            "sdc",
            "crash_hang",
            "avg_time",
            "median_time",
        ])

        for idx, binary in enumerate(EXECUTABLES, start=1):
            print(f"[{idx:2d}/{total_bins}] Processing {binary}")

            classification = classify_outputs(binary)
            avg_time, median_time = get_execution_time_stats(binary)

            if classification is None:
                print(f"      [WARN] Missing output for {binary}")
                continue

            total_runs, masked, sdc, crash_or_hang = classification

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