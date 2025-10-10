#!/bin/bash

#SBATCH --cpus-per-task=16
#SBATCH --mem=120G
#SBATCH --time=2-00:00:00
#SBATCH --job-name=LJA_assembly
#SBATCH --mail-user=aline.steiner@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/asteiner/assembly_annotation_course/assembly/LJA/output_lja_%j.o
#SBATCH --error=/data/users/asteiner/assembly_annotation_course/assembly/LJA/error_lja_%j.e
#SBATCH --partition=pibu_el8

WORKDIR="/data/users/asteiner/assembly_annotation_course"
CONTAINER="/containers/apptainer/lja-0.2.sif"
OUTDIR="$WORKDIR/assembly/LJA"
FILE="/data/users/asteiner/assembly_annotation_course/Nemrut-1/ERR11437351.fastq.gz"


mkdir -p $OUTDIR


apptainer exec --bind /data $CONTAINER lja --diploid -o $OUTDIR --reads $FILE