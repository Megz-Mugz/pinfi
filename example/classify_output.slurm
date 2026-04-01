#!/bin/bash
#SBATCH --job-name=classify_patricia_large
#SBATCH --partition=normal
#SBATCH --mem=32G
#SBATCH --output=classify_bm_small_%j.out
#SBATCH --error=classify_bm_small_%j.err
#SBATCH --mail-user=rmengle@gmu.edu
#SBATCH --time=02:00:00         
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --exclusive

# ------------------------------------------------------------
# Go to project directory
# ------------------------------------------------------------
cd /home/rmengle/pin/source/tools/pinfi/example

echo "Starting classification job..."
echo "Running on node: $(hostname)"
echo "Start time: $(date)"
echo

# ------------------------------------------------------------
# Run classifier
# ------------------------------------------------------------
python3 classify_output.py

echo
echo "Finished classification."
echo "End time: $(date)"