#!/bin/bash
#SBATCH --job-name=time_patricia_small
#SBATCH --partition=normal
#SBATCH --output=logs/timing_%A_%a.out
#SBATCH --error=logs/timing_%A_%a.err
#SBATCH --mem=2G
#SBATCH --time=00:20:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --exclusive
#SBATCH --array=0-120

module purge
module load gcc
module load llvm/15
module load python

# ============================================================
# 🔥 EDIT THIS ONLY
# ============================================================

EXEC_DIR="/home/rmengle/pin/source/tools/pinfi/example/paired_executables/patricia_small/execs"
NUM_RUNS=1000
BASE_DIR="/projects/lyang28/rmengle/execution_times/paired"

# ============================================================

mkdir -p logs

BENCHMARK_NAME=$(echo "$EXEC_DIR" | sed -E 's|.*/paired_executables/([^/]+)/execs.*|\1|')
OUTPUT_ROOT="$BASE_DIR/${BENCHMARK_NAME}_outputs"

mkdir -p "$OUTPUT_ROOT"

if [ ! -d "$EXEC_DIR" ]; then
    echo "ERROR: Executable directory not found: $EXEC_DIR"
    exit 1
fi

mapfile -t EXECUTABLES < <(find "$EXEC_DIR" -type f -executable | sort)

TOTAL=${#EXECUTABLES[@]}

if [ "$SLURM_ARRAY_TASK_ID" -ge "$TOTAL" ]; then
    echo "Array task $SLURM_ARRAY_TASK_ID exceeds executable count $TOTAL"
    exit 0
fi

EXEC="${EXECUTABLES[$SLURM_ARRAY_TASK_ID]}"
EXEC_NAME=$(basename "$EXEC")

REL_DIR=$(dirname "${EXEC#$EXEC_DIR/}")

if [ "$REL_DIR" = "." ]; then
    OUT_DIR="$OUTPUT_ROOT"
else
    OUT_DIR="$OUTPUT_ROOT/$REL_DIR"
fi

mkdir -p "$OUT_DIR"

OUTFILE="$OUT_DIR/${EXEC_NAME}.txt"
rm -f "$OUTFILE"

echo "=================================="
echo "Array task ID: $SLURM_ARRAY_TASK_ID"
echo "Node: $(hostname)"
echo "Executable: $EXEC_NAME"
echo "Subfolder: $REL_DIR"
echo "Full path: $EXEC"
echo "Output file: $OUTFILE"
echo "Start Time: $(date)"
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
echo "End Time: $(date)"