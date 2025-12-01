#!/bin/bash
#SBATCH --job-name=MAKER
#SBATCH --partition=pibu_el8 
#SBATCH --cpus-per-task=4
#SBATCH --mem=64G
#SBATCH --time=02:00:00
#SBATCH --output=gene_annotation/MAKER/logs/%x_%j.out
#SBATCH --error=gene_annotation/MAKER/logs/%x_%j.err
# User-editable variables

WORKDIR=/data/users/asteiner/assembly_annotation_course/gene_annotation/MAKER
CONTAINER=/data/courses/assembly-annotation-course/CDS_annotation/containers/MAKER_3.01.03.sif


cd $WORKDIR

apptainer exec --bind /data $CONTAINER maker -CTL
