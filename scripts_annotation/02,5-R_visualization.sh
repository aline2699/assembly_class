#!/bin/bash
#SBATCH --job-name=R_visualization_circlize
#SBATCH --partition=pibu_el8 
#SBATCH --cpus-per-task=4
#SBATCH --mem=64G
#SBATCH --time=02:00:00
#SBATCH --output=R_visualizations/logs/%x_%j.out
#SBATCH --error=R_visualizations/logs/%x_%j.err


#module load R-bundle-CRAN/2023.11-foss-2021a #works for full_length_LTR_identity
module load R-bundle-IBU/2023072800-foss-2021a-R-4.2.1 # works for circlize

#Rscript scripts_annotation/02-full_length_LTR_identity.R
Rscript scripts_annotation/03-annotation_circlize.R
