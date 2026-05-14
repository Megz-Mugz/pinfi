#!/bin/bash
#SBATCH --job-name=gvn
#SBATCH --partition=normal
#SBATCH --mem=32G
#SBATCH --output=logs/gvn_%A_%a.out
#SBATCH --error=logs/gvn_%A_%a.err
#SBATCH --mail-user=rmengle@gmu.edu
#SBATCH --time=02:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --exclusive
#SBATCH --array=0-10

cd /home/rmengle/pin/source/tools/pinfi/example

mkdir -p logs

EXEC_DIR="paired_executables/dijkstra_small/execs/leader-gvn"
RUNS=1000
INPUT_ARGS=""

executables=("$EXEC_DIR"/*)

executable="${executables[$SLURM_ARRAY_TASK_ID]}"
executable_name=$(basename "$executable")

echo "Starting FI array task..."
echo "Array task ID: $SLURM_ARRAY_TASK_ID"
echo "Executable: $executable_name"
echo "Node: $(hostname)"
echo "Start time: $(date)"
echo

python3 faultinject.py "$executable_name" "$RUNS" "$INPUT_ARGS"

echo
echo "Finished: $executable_name"
echo "End time: $(date)"