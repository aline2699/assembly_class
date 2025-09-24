#!/bin/bash

#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=flye_assembly
#SBATCH --mail-user=aline.steiner@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/asteiner/assembly_annotation_course/assembly/flye/output_fastqc_%j.o
#SBATCH --error=/data/users/asteiner/assembly_annotation_course/assembly/flye/error_fastqc_%j.e
#SBATCH --partition=pibu_el8

WORKDIR="/data/users/asteiner/assembly_annotation_course"
CONTAINER="/containers/apptainer/flye_2.9.5.sif"
OUTDIR="$WORKDIR/assembly/flye"
FILE="/data/users/asteiner/assembly_annotation_course/Nemrut-1/ERR11437351.fastq.gz"

mkdir -p $OUTDIR

apptainer exec --bind /data $CONTAINER flye --pacbio-hifi $FILE --out-dir $OUTDIR --threads 16