import os
import statistics
import csv

# =============================================================
# Configuration
# =============================================================

# ------------------------------------------------------------
# TODO: CHANGE BENCHMARK NAME & OPT LEADER FOR PAIS
# ------------------------------------------------------------
BENCHMARK_NAME = "basicmath_small"
BENCHMARK_NAME_FOR_GOLDEN = "basicmath_small"
OPT_LEADER = "gvn"

SCRATCH_OUTPUT_ROOT = (
    f"/projects/lyang28/rmengle/program_outputs/paired/"
    f"{BENCHMARK_NAME}_outputs/leader-{OPT_LEADER}"
)

# FOR TESTING


EXECUTION_TIMES_ROOT = (
    f"/projects/lyang28/rmengle/execution_times/paired/"
    f"{BENCHMARK_NAME}_executables"
)

GOLDEN_FILE = \
    f"baseline/golden_{BENCHMARK_NAME}_output.txt"

CSV_OUTPUT_FILE = \
    f"{BENCHMARK_NAME}_reliability_data.csv"

# -------------------------------------------------------------
# Verification logging root
# -------------------------------------------------------------
VERIFICATION_ROOT = "verification_logs"

MASKED_LOG_DIR = \
    os.path.join(VERIFICATION_ROOT, "masked")

SDC_LOG_DIR = \
    os.path.join(VERIFICATION_ROOT, "sdc")

CRASH_LOG_DIR = \
    os.path.join(VERIFICATION_ROOT, "crash")

os.makedirs(MASKED_LOG_DIR, exist_ok=True)
os.makedirs(SDC_LOG_DIR, exist_ok=True)
os.makedirs(CRASH_LOG_DIR, exist_ok=True)

# =============================================================
# Fault Injection Metadata Filters
# =============================================================

IGNORE_PREFIXES = (
    "include",
    "all",
    "exclude",
    "Inject into bit"
)

def normalize_output(contents):

    if contents is None:
        return None

    cleaned_lines = []

    for line in contents.splitlines():

        stripped = line.strip()

        if not stripped:
            continue

        if any(stripped.startswith(prefix)
               for prefix in IGNORE_PREFIXES):
            continue

        cleaned_lines.append(stripped)

    return "\n".join(cleaned_lines)

# =============================================================
# Discover output folders
# =============================================================

def discover_output_folders(root_dir):

    if not os.path.isdir(root_dir):
        raise FileNotFoundError(
            f"Output directory not found: {root_dir}"
        )

    folders = []

    for fname in sorted(os.listdir(root_dir)):
        full_path = os.path.join(root_dir, fname)

        if os.path.isdir(full_path):
            folders.append(fname)

    if not folders:
        raise RuntimeError(
            "No output folders found."
        )

    return folders


OUTPUT_FOLDERS = \
    discover_output_folders(SCRATCH_OUTPUT_ROOT)

print("\nDiscovered output folders:")
for i, f in enumerate(OUTPUT_FOLDERS, 1):
    print(f" {i:2d}. {f}")
print()

# =============================================================
# Helpers
# =============================================================

def load_file(path):
    try:
        with open(path, "r") as f:
            return f.read()
    except Exception:
        return None


golden_output_raw = load_file(GOLDEN_FILE)

if golden_output_raw is None:
    raise RuntimeError(
        "Golden output not found or unreadable."
    )

golden_output = \
    normalize_output(golden_output_raw)

# =============================================================
# Timing path helper (NEW — single source of truth)
# =============================================================

def get_timing_file_path(folder_name):
    """
    Returns the expected timing file path for a given folder.
    Uses safe suffix stripping.
    """
    if folder_name.endswith("_exec"):
        base_name = folder_name[:-5]
    else:
        base_name = folder_name

    return os.path.join(
        EXECUTION_TIMES_ROOT,
        f"{base_name}_exec.txt"
    )

# =============================================================
# Classification + Verification Logging
# =============================================================

def classify_outputs(folder_name):

    folder_path = os.path.join(
        SCRATCH_OUTPUT_ROOT,
        folder_name
    )

    masked = 0
    sdc = 0
    crash_or_hang = 0
    total_runs = 0

    first_masked_file = None
    first_sdc_file = None
    first_crash_file = None

    files = [
        f for f in os.listdir(folder_path)
        if os.path.isfile(
            os.path.join(folder_path, f)
        )
    ]

    total_files = len(files)

    print(f"    Found {total_files} run files")

    for idx, fname in enumerate(
        sorted(files),
        start=1, 
    ):

        percent = (idx / total_files) * 100

        print(
            f"\r    ↳ [{idx:4d}/{total_files} | "
            f"{percent:5.1f}%] {fname}",
            end="",
            flush=True
        )

        full_path = os.path.join(folder_path, fname)

        try:
            with open(full_path, "r") as f:

                raw_contents = f.read()
                normalized_contents = normalize_output(raw_contents)

                total_runs += 1

                # Crash / Hang
                if not any(c.isdigit() for c in normalized_contents):
                    crash_or_hang += 1
                    if first_crash_file is None:
                        first_crash_file = fname

                # Masked
                elif normalized_contents == golden_output:
                    masked += 1
                    if first_masked_file is None:
                        first_masked_file = fname

                # SDC
                else:
                    sdc += 1
                    if first_sdc_file is None:
                        first_sdc_file = fname

        except Exception:
            continue

    print()

    # Write verification logs
    if first_masked_file:
        with open(
            os.path.join(MASKED_LOG_DIR, f"{folder_name}_masked.txt"),
            "w"
        ) as f:
            f.write(f"First masked file:\n{first_masked_file}\n")

    if first_sdc_file:
        with open(
            os.path.join(SDC_LOG_DIR, f"{folder_name}_sdc.txt"),
            "w"
        ) as f:
            f.write(f"First SDC file:\n{first_sdc_file}\n")

    if first_crash_file:
        with open(
            os.path.join(CRASH_LOG_DIR, f"{folder_name}_crash.txt"),
            "w"
        ) as f:
            f.write(f"First crash/hang file:\n{first_crash_file}\n")

    return total_runs, masked, sdc, crash_or_hang

# =============================================================
# Timing statistics
# =============================================================

def get_execution_time_stats(folder_name):

    timing_file = get_timing_file_path(folder_name)

    if not os.path.isfile(timing_file):
        print(f"   [WARN] Missing timing file: {timing_file}")
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

    total_bins = len(OUTPUT_FOLDERS)

    print("\nStarting classification...\n")

    with open(CSV_OUTPUT_FILE, "w", newline="") as csvfile:

        writer = csv.writer(csvfile)

        writer.writerow([
            "executable",
            "total_runs",
            "masked",
            "sdc",
            "crash_hang",
            "avg_time",
            "median_time",
        ])

        for idx, folder in enumerate(OUTPUT_FOLDERS, start=1):

            percent = (idx / total_bins) * 100

            # ✅ NEW DEBUG VISIBILITY
            timing_file = get_timing_file_path(folder)
            timing_exists = os.path.isfile(timing_file)

            print(
                f"[{idx:3d}/{total_bins} | {percent:5.1f}%] Processing {folder}\n"
                f"    FI folder : {os.path.join(SCRATCH_OUTPUT_ROOT, folder)}\n"
                f"    Timing    : {timing_file} "
                f"{'✓' if timing_exists else '✗ MISSING'}"
            )

            total_runs, masked, sdc, crash_or_hang = \
                classify_outputs(folder)

            avg_time, median_time = \
                get_execution_time_stats(folder)

            writer.writerow([
                folder,
                total_runs,
                masked,
                sdc,
                crash_or_hang,
                f"{avg_time:.6f}" if avg_time else "",
                f"{median_time:.6f}" if median_time else "",
            ])

    print(f"\nCSV written to: {CSV_OUTPUT_FILE}\n")

    print(
        "Verification logs written to:\n"
        f"  {VERIFICATION_ROOT}/masked\n"
        f"  {VERIFICATION_ROOT}/sdc\n"
        f"  {VERIFICATION_ROOT}/crash\n"
    )