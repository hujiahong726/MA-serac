#!/bin/bash
#SBATCH --account=pr_255_general            # Project ID
#SBATCH --nodes=1                         # Use a single node
#SBATCH --ntasks=1                          # One main task (running SERAC)
#SBATCH --cpus-per-task=8                   # Request 8 CPU cores to assist with data loading and preprocessing
#SBATCH --time=2:00:00                      # Adjust time limit based on expected runtime; set to 2 hours here
#SBATCH --mem=32GB                          # Request more memory (adjust if your job fails due to memory issues)
#SBATCH --job-name=serac-trial-run          # Descriptive job name for SERAC
#SBATCH --output=serac-trial-run.out        # Output log file
#SBATCH --gres=gpu:v100:1                   # Request a V100 GPU (can adjust to rtx8000 or other if available and needed)
#SBATCH --requeue

export WANDB_API_KEY="75dc083a811ed1d119056d00c5989febffbb2684"

module purge

# Load required modules
module load anaconda3/2024.02

# activate virtual environment
source activate /scratch/jh9184/myenv

# run
python -m run +alg=rep +experiment=qa +model=t5large batch_size=10 val_batch_size=10 data.zsre_impl=true data.zsre_yn=true data.hard_neg=true

# deactivate virtual environment
conda deactivate