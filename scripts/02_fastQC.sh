#!/bin/bash

#SBATCH --cpus-per-task=1
#SBATCH --mem=40G
#SBATCH --time=01:00:00
#SBATCH --job-name=fastqc
#SBATCH --mail-user=aline.steiner@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/asteiner/assembly_annotation_course/read_QC/output_fastqc_%j.o
#SBATCH --error=/data/users/asteiner/assembly_annotation_course/read_QC/error_fastqc_%j.e
#SBATCH --partition=pibu_el8

WORKDIR="/data/users/asteiner/assembly_annotation_course" 
CONTAINER="/containers/apptainer/fastqc-0.12.1.sif"
OUTDIR="$WORKDIR/read_QC"

apptainer exec --bind /data /containers/apptainer/fastqc-0.12.1.sif fastqc -o $OUTDIR $WORKDIR/Nemrut-1/* $WORKDIR/RNAseq_Sha/*