import os
import statistics
import csv
import time
from datetime import datetime

# =============================================================
# Configuration
# =============================================================

BENCHMARK_NAME = "dijkstra_small"

SCRATCH_OUTPUT_ROOT = (
    f"/projects/lyang28/rmengle/program_outputs/paired/"
    f"{BENCHMARK_NAME}_outputs"
)

EXECUTION_TIMES_ROOT = (
    f"/projects/lyang28/rmengle/execution_times/paired/"
    f"{BENCHMARK_NAME}_outputs"
)

GOLDEN_FILE = f"baseline/golden_{BENCHMARK_NAME}_output.txt"

CSV_OUTPUT_FILE = f"{BENCHMARK_NAME}_paired_reliability_data.csv"

VERIFICATION_ROOT = "verification_logs"
RUN_LOG_FILE = f"{BENCHMARK_NAME}_paired_classification.log"

MASKED_LOG_DIR = os.path.join(VERIFICATION_ROOT, "masked")
SDC_LOG_DIR = os.path.join(VERIFICATION_ROOT, "sdc")
CRASH_LOG_DIR = os.path.join(VERIFICATION_ROOT, "crash")

os.makedirs(MASKED_LOG_DIR, exist_ok=True)
os.makedirs(SDC_LOG_DIR, exist_ok=True)
os.makedirs(CRASH_LOG_DIR, exist_ok=True)

IGNORE_PREFIXES = (
    "include",
    "all",
    "exclude",
    "Inject into bit"
)

LOG_EVERY_N_FILES = 100

# =============================================================
# Logging helper
# =============================================================

def log(msg="", also_print=True):
    timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    line = f"[{timestamp}] {msg}"

    with open(RUN_LOG_FILE, "a") as f:
        f.write(line + "\n")

    if also_print:
        print(line, flush=True)


# reset log file each run
with open(RUN_LOG_FILE, "w") as f:
    f.write(f"Classification log started at {datetime.now()}\n\n")

# =============================================================
# Helpers
# =============================================================

def normalize_output(contents):
    if contents is None:
        return None

    cleaned_lines = []

    for line in contents.splitlines():
        stripped = line.strip()

        if not stripped:
            continue

        if any(stripped.startswith(prefix) for prefix in IGNORE_PREFIXES):
            continue

        cleaned_lines.append(stripped)

    return "\n".join(cleaned_lines)


def load_file(path):
    try:
        with open(path, "r", errors="replace") as f:
            return f.read()
    except Exception as e:
        log(f"[READ ERROR] {path} -> {e}", also_print=False)
        return None


golden_output_raw = load_file(GOLDEN_FILE)

if golden_output_raw is None:
    raise RuntimeError(f"Golden output not found: {GOLDEN_FILE}")

golden_output = normalize_output(golden_output_raw)

# =============================================================
# Discover nested exec folders
# =============================================================

def discover_exec_folders(root_dir):
    if not os.path.isdir(root_dir):
        raise FileNotFoundError(f"Output directory not found: {root_dir}")

    exec_folders = []

    log(f"Scanning output root: {root_dir}")

    for dirpath, dirnames, filenames in os.walk(root_dir):
        run_files = [
            f for f in filenames
            if os.path.isfile(os.path.join(dirpath, f))
        ]

        if run_files:
            rel_path = os.path.relpath(dirpath, root_dir)
            exec_folders.append(rel_path)
            log(
                f"Discovered folder: {rel_path} "
                f"({len(run_files)} files)",
                also_print=False
            )

    if not exec_folders:
        raise RuntimeError("No executable output folders with files found.")

    return sorted(exec_folders)


OUTPUT_FOLDERS = discover_exec_folders(SCRATCH_OUTPUT_ROOT)

log("")
log("Discovered executable output folders:")
for i, folder in enumerate(OUTPUT_FOLDERS, 1):
    log(f" {i:3d}. {folder}")
log("")

# =============================================================
# Timing helper
# =============================================================

def get_timing_file_path(relative_folder):
    exec_name = os.path.basename(relative_folder)
    leader_name = os.path.dirname(relative_folder)

    return os.path.join(
        EXECUTION_TIMES_ROOT,
        leader_name,
        f"{exec_name}.txt"
    )

# =============================================================
# Classification
# =============================================================

def classify_outputs(relative_folder):
    folder_path = os.path.join(SCRATCH_OUTPUT_ROOT, relative_folder)

    masked = 0
    sdc = 0
    crash_or_hang = 0
    total_runs = 0

    first_masked_file = None
    first_sdc_file = None
    first_crash_file = None

    files = [
        f for f in os.listdir(folder_path)
        if (
            os.path.isfile(os.path.join(folder_path, f))
            and f.startswith("output_")
        )
    ]

    total_files = len(files)

    log(f"    Found {total_files} run files")

    folder_start = time.time()

    for idx, fname in enumerate(sorted(files), start=1):
        full_path = os.path.join(folder_path, fname)
        raw_contents = load_file(full_path)

        if raw_contents is None:
            crash_or_hang += 1
            total_runs += 1
            if first_crash_file is None:
                first_crash_file = fname
            continue

        normalized_contents = normalize_output(raw_contents)
        total_runs += 1

        if normalized_contents is None or not any(c.isdigit() for c in normalized_contents):
            crash_or_hang += 1
            if first_crash_file is None:
                first_crash_file = fname

        elif normalized_contents == golden_output:
            masked += 1
            if first_masked_file is None:
                first_masked_file = fname

        else:
            sdc += 1
            if first_sdc_file is None:
                first_sdc_file = fname

        if idx % LOG_EVERY_N_FILES == 0 or idx == total_files:
            elapsed = time.time() - folder_start
            rate = idx / elapsed if elapsed > 0 else 0

            log(
                f"    Progress {idx}/{total_files} files "
                f"({(idx / total_files) * 100:5.1f}%) | "
                f"masked={masked}, sdc={sdc}, crash/hang={crash_or_hang} | "
                f"{rate:.2f} files/sec"
            )

    safe_name = relative_folder.replace("/", "__")

    if first_masked_file:
        with open(os.path.join(MASKED_LOG_DIR, f"{safe_name}_masked.txt"), "w") as f:
            f.write(f"Folder:\n{relative_folder}\n\nFirst masked file:\n{first_masked_file}\n")

    if first_sdc_file:
        with open(os.path.join(SDC_LOG_DIR, f"{safe_name}_sdc.txt"), "w") as f:
            f.write(f"Folder:\n{relative_folder}\n\nFirst SDC file:\n{first_sdc_file}\n")

    if first_crash_file:
        with open(os.path.join(CRASH_LOG_DIR, f"{safe_name}_crash.txt"), "w") as f:
            f.write(f"Folder:\n{relative_folder}\n\nFirst crash/hang file:\n{first_crash_file}\n")

    log(
        f"    Done folder: total={total_runs}, masked={masked}, "
        f"sdc={sdc}, crash/hang={crash_or_hang}"
    )

    return total_runs, masked, sdc, crash_or_hang

# =============================================================
# Timing statistics
# =============================================================

def get_execution_time_stats(relative_folder):
    timing_file = get_timing_file_path(relative_folder)

    if not os.path.isfile(timing_file):
        log(f"   [WARN] Missing timing file: {timing_file}")
        return None, None

    times = []

    with open(timing_file, "r", errors="replace") as f:
        for line in f:
            line = line.strip()

            if not line:
                continue

            try:
                times.append(float(line))
            except ValueError:
                continue

    if not times:
        log(f"   [WARN] Timing file exists but no valid times: {timing_file}")
        return None, None

    return sum(times) / len(times), statistics.median(times)

# =============================================================
# Main CSV generation
# =============================================================

# =============================================================
# Main CSV generation
# =============================================================

if __name__ == "__main__":

    start_time = time.time()
    total_bins = len(OUTPUT_FOLDERS)

    log("Starting classification")
    log(f"CSV output file: {CSV_OUTPUT_FILE}")
    log(f"Log file: {RUN_LOG_FILE}")
    log("")

    with open(CSV_OUTPUT_FILE, "w", newline="") as csvfile:
        writer = csv.writer(csvfile)

        writer.writerow([
            "benchmark",
            "leader_opt",
            "second_opt",
            "paired_executable",
            "relative_folder",
            "total_runs",
            "masked",
            "sdc",
            "crash_hang",
            "masked_rate",
            "sdc_rate",
            "crash_hang_rate",
            "avg_time",
            "median_time",
        ])

        for idx, relative_folder in enumerate(OUTPUT_FOLDERS, start=1):
            percent = (idx / total_bins) * 100

            leader_opt = relative_folder.split(os.sep)[0].replace("leader-", "")
            paired_executable = os.path.basename(relative_folder)

            # =====================================================
            # Extract second optimization
            # Example:
            # exec_basicmath_small_early-cse_loop-reduce_exec
            # -> loop-reduce
            # =====================================================

            exec_prefix = f"exec_{BENCHMARK_NAME}_"
            exec_suffix = "_exec"

            second_opt = paired_executable

            if second_opt.startswith(exec_prefix):
                second_opt = second_opt[len(exec_prefix):]

            if second_opt.endswith(exec_suffix):
                second_opt = second_opt[:-len(exec_suffix)]

            parts = second_opt.split("_", 1)
            second_opt = parts[1] if len(parts) == 2 else ""

            timing_file = get_timing_file_path(relative_folder)
            timing_exists = os.path.isfile(timing_file)

            log("=" * 80)
            log(
                f"[{idx:4d}/{total_bins} | {percent:5.1f}%] "
                f"Processing {relative_folder}"
            )
            log(f"    FI folder : {os.path.join(SCRATCH_OUTPUT_ROOT, relative_folder)}")
            log(f"    Timing    : {timing_file} {'FOUND' if timing_exists else 'MISSING'}")

            total_runs, masked, sdc, crash_or_hang = classify_outputs(relative_folder)

            avg_time, median_time = get_execution_time_stats(relative_folder)

            masked_rate = masked / total_runs if total_runs else 0
            sdc_rate = sdc / total_runs if total_runs else 0
            crash_rate = crash_or_hang / total_runs if total_runs else 0

            writer.writerow([
                BENCHMARK_NAME,
                leader_opt,
                second_opt,
                paired_executable,
                relative_folder,
                total_runs,
                masked,
                sdc,
                crash_or_hang,
                f"{masked_rate:.6f}",
                f"{sdc_rate:.6f}",
                f"{crash_rate:.6f}",
                f"{avg_time:.6f}" if avg_time is not None else "",
                f"{median_time:.6f}" if median_time is not None else "",
            ])

            csvfile.flush()

            log(
                f"    CSV row written for {relative_folder} | "
                f"masked_rate={masked_rate:.6f}, "
                f"sdc_rate={sdc_rate:.6f}, "
                f"crash_rate={crash_rate:.6f}"
            )

    elapsed_total = time.time() - start_time

    log("")
    log(f"CSV written to: {CSV_OUTPUT_FILE}")
    log(f"Log written to: {RUN_LOG_FILE}")
    log(f"Total elapsed time: {elapsed_total:.2f} seconds")

    log(
        "Verification logs written to:\n"
        f"  {VERIFICATION_ROOT}/masked\n"
        f"  {VERIFICATION_ROOT}/sdc\n"
        f"  {VERIFICATION_ROOT}/crash"
    )
