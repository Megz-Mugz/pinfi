#!/bin/bash
#SBATCH --job-name=fi_leader_gvn
#SBATCH --partition=normal
#SBATCH --mem=32G
#SBATCH --output=fi_leader_gvn_%j.out
#SBATCH --error=fi_leader_gvn_%j.err
#SBATCH --mail-user=rmengle@gmu.edu
#SBATCH --time=02:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --exclusive

cd /home/rmengle/pin/source/tools/pinfi/example

echo "Starting fault injection campaign..."
echo "Running on node: $(hostname)"
echo "Start time: $(date)"
echo

EXEC_DIR="paired_executables/basicmath_small/execs/leader-gvn"
RUNS=1000
INPUT_ARGS=""

for executable in "$EXEC_DIR"/*; do
    # skip non-files
    [ -f "$executable" ] || continue

    # skip non-executable files
    [ -x "$executable" ] || continue

    executable_name=$(basename "$executable")

    echo "======================================="
    echo "Running FI for: $executable_name"
    echo "Command: python3 faultinject.py $executable_name $RUNS \"$INPUT_ARGS\""
    echo "======================================="

    python3 faultinject.py "$executable_name" "$RUNS" "$INPUT_ARGS"

    echo
done

echo "Finished fault injection campaign."
echo "End time: $(date)"