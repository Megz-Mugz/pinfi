#!/bin/sh
#SBATCH --partition=normal
#SBATCH --output=/home/rmengle/pin/source/tools/pinfi/example/timing_%j.out
#SBATCH --error=/home/rmengle/pin/source/tools/pinfi/example/timing_%j.err
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=rmengle@gmu.edu
#SBATCH --mem=2G
#SBATCH --time=01:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

module purge
module load gcc
module load llvm/15

cd /home/rmengle/pin/source/tools/pinfi/example || exit 1

# ---------------------------------------------------
# Single source of truth
# ---------------------------------------------------
EXEC_NAME="basicmath_O1_exec"
EXEC_DIR="basicmath_small_executables"
EXEC="${EXEC_DIR}/${EXEC_NAME}"

NUM_RUNS=1000
TIMING_DIR="execution_times"
TIMING_FILE="${TIMING_DIR}/${EXEC_NAME}.txt"

mkdir -p "$TIMING_DIR"
rm -f "$TIMING_FILE"

echo "=== Timing Job Started ==="
echo "Job ID: $SLURM_JOB_ID"
echo "Executable: $EXEC_NAME"
echo "Hostname: $(hostname)"
echo "Start Time: $(date)"

# Warm-up
for i in {1..20}; do
    $EXEC > /dev/null
done

# Timed runs
for i in $(seq 1 $NUM_RUNS); do
    START=$(date +%s.%N)
    $EXEC > /dev/null
    END=$(date +%s.%N)

    echo "$(echo "$END - $START" | bc)" >> "$TIMING_FILE"
done

echo "Timing data written to: $TIMING_FILE"
echo "End Time: $(date)"