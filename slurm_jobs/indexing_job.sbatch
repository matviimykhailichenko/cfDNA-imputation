#!/usr/bin/env bash
#SBATCH --job-name=galushka
#SBATCH --nodelist=sy096
#SBATCH --cpus-per-task=40
#SBATCH --mem=64G
#SBATCH --time=24:00:00
#SBATCH --output=%x-%j.out
#SBATCH --error=%x-%j.err

set -euo pipefail

# Load environment / modules for Snakemake
# Example:
# module load python/3.10 snakemake/7.32.4
# or activate your conda env:
source ~/miniconda3/etc/profile.d/conda.sh
conda activate galushka

bwa-mem2 index /home/gpfs/o_mykhaili/galushka/references/GCF_000001405.26_GRCh38_genomic.fna.gz
