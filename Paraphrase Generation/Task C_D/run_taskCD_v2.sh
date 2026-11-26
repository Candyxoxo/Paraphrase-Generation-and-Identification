#!/bin/bash
#SBATCH --job-name=taskCD
#SBATCH --partition=gpu-short
#SBATCH --gres=gpu:1                       # one GPU, any type...
#SBATCH --constraint="zen2|cascadelake"    # ...but only A100 (zen2) or H200 (cascadelake) nodes
#SBATCH --exclude=d1025                    # d1025 is cascadelake but has T4s, so block it
#SBATCH --mem=64G
#SBATCH --time=02:00:00
#SBATCH --output=logs/taskCD_%j.log
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=gandhi.gau@northeastern.edu

cd /home/gandhi.gau/NLP_Project
export HF_HOME=/scratch/gandhi.gau/hf_cache

echo "Started on $(hostname) at $(date)"
nvidia-smi --query-gpu=name,memory.total --format=csv,noheader

# run the whole notebook and save the executed copy
/home/gandhi.gau/.conda/envs/my_gpu_env/bin/python -m papermill \
    Para_gen_part2_v2.ipynb Para_gen_part2_v2_executed.ipynb -k my_gpu_env

echo "Finished at $(date)"
