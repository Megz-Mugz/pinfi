#!/bin/bash

# ============================================================
# Generic FI submitter
# Works for ANY executable directory
# Just change EXEC_DIR path
# ============================================================

FI_DIR="/home/rmengle/pin/source/tools/pinfi/example"

# ------------------------------------------------------------
# TODO: CHANGE THIS ONLY
# ------------------------------------------------------------
EXEC_DIR="$FI_DIR/benchmarks/qsort/qsort_small_executables"

INJECTIONS=1000

# ============================================================
# Validate directory
# ============================================================
cd "$EXEC_DIR" || {
    echo "ERROR: Could not cd into $EXEC_DIR"
    exit 1
}

echo "Submitting jobs from: $(pwd)"
echo "--------------------------------------------------"

# Extract folder name (for logging clarity)
DATASET_NAME=$(basename "$EXEC_DIR")

echo "Dataset detected: $DATASET_NAME"
echo

# ============================================================
# Loop through ALL executables in directory
# ============================================================
for exe in *_exec; do

    # Skip non-files
    [ -f "$exe" ] || continue

    job_name="fi_${exe}"

    echo "Submitting job: $job_name"

    sbatch <<EOF
#!/bin/sh
#SBATCH --job-name=$job_name
#SBATCH --partition=normal
#SBATCH --output=$FI_DIR/${exe}.out
#SBATCH --error=$FI_DIR/${exe}.err
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=rmengle@gmu.edu
#SBATCH --mem=2G
#SBATCH --time=3-0:00:00           
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --exclusive

module purge
module load gcc
module load llvm/15
module load python

cd $FI_DIR || {
    echo "ERROR: failed to cd into example directory"
    exit 1
}

echo "=== FI Job Started ==="
echo "Dataset: $DATASET_NAME"
echo "Executable: $exe"
echo "Hostname: \$(hostname)"
echo "PWD: \$(pwd)"
echo "Start Time: \$(date)"

python3 faultinject.py $exe $INJECTIONS ""

echo "=== FI Job Finished ==="
echo "End Time: \$(date)"
EOF

done

echo "--------------------------------------------------"
echo "All jobs submitted."