#!/bin/bash
#SBATCH --job-name=timing_job
#SBATCH --partition=normal
#SBATCH --output=timing_%j.out
#SBATCH --error=timing_%j.err
#SBATCH --mem=2G
#SBATCH --time=00:20:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

module purge
module load gcc
module load llvm/15
module load python

# ============================================================
# 🔥 EDIT THIS ONLY
# ============================================================

EXEC="/home/rmengle/pin/source/tools/pinfi/example/paired_executables/basicmath_small/execs/exec_basicmath_small_early-cse_simple-loop-unswitch"

NUM_RUNS=1000

# ============================================================

BASE_DIR="/projects/lyang28/rmengle/execution_times/paired/basicmath_small"
mkdir -p "$BASE_DIR"

OUTFILE="$BASE_DIR/$(basename $EXEC).txt"
rm -f "$OUTFILE"

echo "=================================="
echo "Executable: $EXEC"
echo "Hostname: $(hostname)"
echo "Start Time: $(date)"
echo "Output file: $OUTFILE"
echo "=================================="

# Sanity check
if [ ! -x "$EXEC" ]; then
    echo "ERROR: Executable not found or not executable"
    exit 1
fi

# Warm-up
for i in $(seq 1 20); do
    "$EXEC" > /dev/null
done

# Timed runs
for i in $(seq 1 $NUM_RUNS); do
    START=$(date +%s.%N)
    "$EXEC" > /dev/null
    END=$(date +%s.%N)

    python3 - <<PY >> "$OUTFILE"
start = float("$START")
end = float("$END")
print(end - start)
PY
done

echo "=================================="
echo "Done. Output file: $OUTFILE"
echo "End Time: $(date)"