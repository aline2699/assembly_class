#!/bin/bash

#SBATCH --cpus-per-task=1
#SBATCH --mem=40G
#SBATCH --time=01:00:00
#SBATCH --job-name=fastp
#SBATCH --mail-user=aline.steiner@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/asteiner/assembly_annotation_course/read_QC/fastp_results/output_fastqc_%j.o
#SBATCH --error=/data/users/asteiner/assembly_annotation_course/read_QC/fastp_results/error_fastqc_%j.e
#SBATCH --partition=pibu_el8

WORKDIR="/data/users/asteiner/assembly_annotation_course" 
CONTAINER="/containers/apptainer/fastp_0.24.1.sif"
OUTDIR="$WORKDIR/read_QC/fastp_results"

# Run fastp on RNAseq_Sha
apptainer exec --bind /data $CONTAINER fastp -i $WORKDIR/RNAseq_Sha/ERR754081_1.fastq.gz -I $WORKDIR/RNAseq_Sha/ERR754081_2.fastq.gz -o $OUTDIR/ERR754081_1.fastp -O $OUTDIR/ERR754081_2.fastp -j $OUTDIR/fastp_RNA.json -h $OUTDIR/fastp_RNA.html

# Run fastp on Nemrut-1 without quality filtering (-Q)
apptainer exec --bind /data $CONTAINER fastp -i $WORKDIR/Nemrut-1/ERR11437351.fastq.gz -o $OUTDIR/ERR11437351.fastp -Q -j $OUTDIR/fastp_DNA.json -h $OUTDIR/fastp_DNA.html