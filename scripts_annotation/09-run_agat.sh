#!/bin/bash
#SBATCH --time=01:00:00
#SBATCH --mem=20G
#SBATCH --partition=pibu_el8
#SBATCH --job-name=agat
#SBATCH --output=gene_annotation/final/logs/%x_%j.out
#SBATCH --error=gene_annotation/final/logs/%x_%j.err

WORKDIR="/data/users/asteiner/assembly_annotation_course/gene_annotation/final"
CONTAINER="/containers/apptainer/agat-1.2.0.sif"

cd $WORKDIR
apptainer exec --bind /data $CONTAINER agat_sp_statistics.pl -i filtered.genes.renamed.gff3 -o annotation.stat