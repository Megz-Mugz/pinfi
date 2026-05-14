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

EXEC_DIR="/home/rmengle/pin/source/tools/pinfi/example/paired_executables/basicmath_small/execs/leader-cse"

NUM_RUNS=1000

BASE_DIR="/projects/lyang28/rmengle"

# ============================================================

mkdir -p "$BASE_DIR"

echo "=================================="
echo "Executable directory: $EXEC_DIR"
echo "Hostname: $(hostname)"
echo "Start Time: $(date)"
echo "Output directory: $BASE_DIR"
echo "=================================="

if [ ! -d "$EXEC_DIR" ]; then
    echo "ERROR: Executable directory not found: $EXEC_DIR"
    exit 1
fi

for EXEC in "$EXEC_DIR"/*; do
    if [ ! -x "$EXEC" ] || [ -d "$EXEC" ]; then
        echo "Skipping non-executable: $EXEC"
        continue
    fi

    EXEC_NAME=$(basename "$EXEC")
    OUTFILE="$BASE_DIR/${EXEC_NAME}.txt"
    rm -f "$OUTFILE"

    echo
    echo "=================================="
    echo "Timing executable: $EXEC_NAME"
    echo "Full path: $EXEC"
    echo "Output file: $OUTFILE"
    echo "=================================="

    for i in $(seq 1 20); do
        "$EXEC" > /dev/null
    done

    for i in $(seq 1 "$NUM_RUNS"); do
        START=$(date +%s.%N)
        "$EXEC" > /dev/null
        END=$(date +%s.%N)

        python3 - <<PY >> "$OUTFILE"
start = float("$START")
end = float("$END")
print(end - start)
PY
    done

    echo "Done timing: $EXEC_NAME"
done

echo
echo "=================================="
echo "All executables done."
echo "End Time: $(date)"
echo "=================================="