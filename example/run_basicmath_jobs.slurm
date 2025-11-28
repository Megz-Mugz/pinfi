#!/bin/sh
#SBATCH --job-name=basicmath_fi
#SBATCH --partition=normal
#SBATCH --output=/home/rmengle/pin/source/tools/pinfi/example/fi_output.out
#SBATCH --error=/home/rmengle/pin/source/tools/pinfi/example/fi_output.err
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=rmengle@gmu.edu
#SBATCH --mem=2G
#SBATCH --time=01:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

module purge
module load gcc
module load llvm/15

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

# ---------------------------------------------------
# Run the fault injection test
# ---------------------------------------------------
echo "Running: python3 faultinject.py ./basicmath_small_loop-unroll4_exec 1000 \"\""
python3 faultinject.py ./basicmath_small_loop-unroll4_exec 1000 ""

echo "=== FI Job Finished ==="
echo "End Time: $(date)"basicmath_small_loop-unroll4_exec