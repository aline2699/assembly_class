#!/bin/bash

#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=Trinity_assembly
#SBATCH --mail-user=aline.steiner@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/asteiner/assembly_annotation_course/assembly/Trinity/output_trinity_%j.o
#SBATCH --error=/data/users/asteiner/assembly_annotation_course/assembly/Trinity/error_trinity_%j.e
#SBATCH --partition=pibu_el8

WORKDIR="/data/users/asteiner/assembly_annotation_course"
OUTDIR="$WORKDIR/assembly/Trinity"
READ1="/data/users/asteiner/assembly_annotation_course/RNAseq_Sha/ERR754081_1.fastq.gz"
READ2="/data/users/asteiner/assembly_annotation_course/RNAseq_Sha/ERR754081_2.fastq.gz"

mkdir -p $OUTDIR

module load Trinity/2.15.1-foss-2021a
Trinity --seqType fq --max_memory 60G --left $READ1 --right $READ2 --CPU 16