#!/bin/bash
#SBATCH --job-name=basicmath_large_instcombine_exec
#SBATCH --partition=normal
#SBATCH --output=/home/rmengle/pin/source/tools/pinfi/example/fi_output_%j.out
#SBATCH --error=/home/rmengle/pin/source/tools/pinfi/example/fi_output_%j.err
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=rmengle@gmu.edu
#SBATCH --mem=2G
#SBATCH --time=01:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8


# ---------------------------------------------------
# Move to your FI working directory
# ---------------------------------------------------
cd /home/rmengle/pin/source/tools/pinfi/example || {
    echo "ERROR: failed to cd into example directory"
    exit 1
}

echo "=== FI Job Started ==="
echo "Hostname: $(hostname)"
echo "PWD: $(pwd)"
echo "Start Time: $(date)"

# ---------------------------------------------------
# CLEAR previous outputs
# ---------------------------------------------------
echo "Clearing previous output directories..."
# rm -f std_output/* 2>/dev/null
# rm -f unroll_output/* 2>/dev/null
# rm -f unoptimized_output/* 2>/dev/null
echo "Cleared."


echo "=== Environment Check ==="
echo "PATH: $PATH"
echo "Python location: $(which python3 || echo NOT_FOUND)"
python3 --version || echo "python3 failed"

echo "=== Listing directory ==="
ls -l

echo "=== About to run FI ==="
set -x
python3 faultinject.py patricia_large_instcombine_exec 1000 ""
echo "=== FI Finished ==="