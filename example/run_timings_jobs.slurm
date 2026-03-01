#!/bin/bash

# ============================================================
# FFT Timing Job Submitter (O0–O3)
# ============================================================

FI_DIR="/home/rmengle/pin/source/tools/pinfi/example"
EXEC_DIR="$FI_DIR/benchmarks/qsort/small_executables"

NUM_RUNS=1000
DATASET_NAME="qsort_small"

# ============================================================
# 🔥 OPTIONAL: Set this to run only ONE executable
# Leave empty ("") to run all fft_O* binaries
# Example: TARGET_EXE="fft_O3"
# ============================================================
TARGET_EXE="qsort_small_O3_exec"

cd "$EXEC_DIR" || {
    echo "ERROR: Could not cd into $EXEC_DIR"
    exit 1
}

echo "Submitting TIMING jobs from: $(pwd)"
echo "--------------------------------------------------"

# ------------------------------------------------------------
# Determine which executables to run
# ------------------------------------------------------------
if [ -n "$TARGET_EXE" ]; then
    EXEC_LIST=("$TARGET_EXE")
else
    EXEC_LIST=(fft_O*)
fi

# ------------------------------------------------------------
# Loop through selected executables
# ------------------------------------------------------------
for exe in "${EXEC_LIST[@]}"; do

    [ -f "$exe" ] || {
        echo "Skipping missing executable: $exe"
        continue
    }

    job_name="timing_${exe}"
    echo "Submitting timing job: $job_name"

    sbatch <<EOF
#!/bin/bash
#SBATCH --job-name=$job_name
#SBATCH --partition=normal
#SBATCH --output=$FI_DIR/timing_${exe}_%j.out
#SBATCH --error=$FI_DIR/timing_${exe}_%j.err
#SBATCH --mem=2G
#SBATCH --time=00:10:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --exclusive

module purge
module load gcc
module load llvm/15

EXEC_PATH="$EXEC_DIR/$exe"
TIMING_DIR="/scratch/rmengle/execution_times/${DATASET_NAME}_executables"
TIMING_FILE="\$TIMING_DIR/${exe}.txt"

mkdir -p "\$TIMING_DIR"
rm -f "\$TIMING_FILE"

echo "=================================="
echo "Timing Job Started"
echo "Executable: $exe"
echo "Hostname: \$(hostname)"
echo "Start Time: \$(date)"
echo "=================================="

# Warm-up
for i in \$(seq 1 20); do
    "\$EXEC_PATH" > /dev/null
done

# Timed runs
for i in \$(seq 1 $NUM_RUNS); do
    START=\$(date +%s.%N)
    "\$EXEC_PATH" > /dev/null
    END=\$(date +%s.%N)

    echo "\$(echo "\$END - \$START" | bc)" >> "\$TIMING_FILE"
done

echo "Timing file written to: \$TIMING_FILE"
echo "End Time: \$(date)"
EOF

done

echo "--------------------------------------------------"
echo "All requested timing jobs submitted."