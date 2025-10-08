#!/bin/bash

#SBATCH --cpus-per-task=16
#SBATCH --mem=32G
#SBATCH --time=02:00:00
#SBATCH --job-name=merqury
#SBATCH --mail-user=aline.steiner@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/asteiner/assembly_annotation_course/assembly_evaluation/merqury/output_fastqc_%j.o
#SBATCH --error=/data/users/asteiner/assembly_annotation_course/assembly_evaluation/merqury/error_fastqc_%j.e
#SBATCH --partition=pibu_el8


WORKDIR="/data/users/asteiner/assembly_annotation_course"
CONTAINER="/containers/apptainer/merqury_1.3.sif"
OUTDIR="$WORKDIR/assembly_evaluation/merqury"

FLYE_FILE="/data/users/asteiner/assembly_annotation_course/assembly/flye/assembly.fasta"
HIFIASM_FILE="/data/users/asteiner/assembly_annotation_course/assembly/hifiasm/ERR11437351.asm.bp.p_ctg.fa"

k=21

export MERQURY="/usr/local/share/merqury"

#apptainer exec --bind /data $CONTAINER sh $MERQURY/best_k.sh 125000000 0.001

#apptainer exec --bind /data $CONTAINER meryl k=$k count $WORKDIR/Nemrut-1/*.fastq.gz output $OUTDIR/$genome.meryl

apptainer exec --bind /data $CONTAINER merqury.sh $OUTDIR/.meryl $FLYE_FILE $WORKDIR/assembly_evaluation/merqury/flye/flye

apptainer exec --bind /data $CONTAINER merqury.sh $OUTDIR/.meryl $HIFIASM_FILE $WORKDIR/assembly_evaluation/merqury/hifiasm/hifiasm