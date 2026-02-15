=#!/bin/bash

# ============================================================
# Generic Timing Job Submitter
# Change EXEC_DIR only
# ============================================================

FI_DIR="/home/rmengle/pin/source/tools/pinfi/example"

# ------------------------------------------------------------
# TODO: CHANGE THIS ONLY
# ------------------------------------------------------------
EXEC_DIR="$FI_DIR/benchmarks/qsort/qsort_small_executables"

NUM_RUNS=1000

# ============================================================
# Validate directory
# ============================================================
cd "$EXEC_DIR" || {
    echo "ERROR: Could not cd into $EXEC_DIR"
    exit 1
}

echo "Submitting TIMING jobs from: $(pwd)"
echo "--------------------------------------------------"

DATASET_NAME=$(basename "$EXEC_DIR")

echo "Dataset detected: $DATASET_NAME"
echo

# ============================================================
# Loop through executables
# ============================================================
for exe in *_exec; do

    [ -f "$exe" ] || continue

    job_name="timing_${exe}"

    echo "Submitting timing job: $job_name"

    sbatch <<EOF
#!/bin/sh
#SBATCH --job-name=$job_name
#SBATCH --partition=normal
#SBATCH --output=$FI_DIR/timing_${exe}_%j.out
#SBATCH --error=$FI_DIR/timing_${exe}_%j.err
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=rmengle@gmu.edu
#SBATCH --mem=2G
#SBATCH --time=04:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --exclusive

module purge
module load gcc
module load llvm/15

cd $FI_DIR || exit 1

# ---------------------------------------------------
# Executable config
# ---------------------------------------------------
EXEC_NAME="$exe"
EXEC_PATH="$EXEC_DIR/\$EXEC_NAME"

# ✅ CHANGED OUTPUT ROOT → SCRATCH
TIMING_DIR="/scratch/rmengle/execution_times/$DATASET_NAME"
TIMING_FILE="\${TIMING_DIR}/\${EXEC_NAME}.txt"

mkdir -p "\$TIMING_DIR"
rm -f "\$TIMING_FILE"

echo "=== Timing Job Started ==="
echo "Dataset: $DATASET_NAME"
echo "Executable: \$EXEC_NAME"
echo "Hostname: \$(hostname)"
echo "Start Time: \$(date)"

# Warm-up runs
for i in {1..20}; do
    "\$EXEC_PATH" > /dev/null
done

# Timed runs
for i in \$(seq 1 $NUM_RUNS); do
    START=\$(date +%s.%N)
    "\$EXEC_PATH" > /dev/null
    END=\$(date +%s.%N)

    echo "\$(echo "\$END - \$START" | bc)" >> "\$TIMING_FILE"
done

echo "Timing data written to: \$TIMING_FILE"
echo "End Time: \$(date)"
EOF

done

echo "--------------------------------------------------"
echo "All timing jobs submitted."