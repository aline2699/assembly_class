#!/bin/bash

#SBATCH --cpus-per-task=16
#SBATCH --mem=32G
#SBATCH --time=02:00:00
#SBATCH --job-name=nucmer
#SBATCH --mail-user=aline.steiner@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/asteiner/assembly_annotation_course/assembly_evaluation/nucmer/output_nucmer_%j.o
#SBATCH --error=/data/users/asteiner/assembly_annotation_course/assembly_evaluation/nucmer/error_nucmer_%j.e
#SBATCH --partition=pibu_el8


WORKDIR="/data/users/asteiner/assembly_annotation_course"
CONTAINER="/containers/apptainer/mummer4_gnuplot.sif"
OUTDIR="$WORKDIR/assembly_evaluation/nucmer"

FLYE_FILE="/data/users/asteiner/assembly_annotation_course/assembly/flye/assembly.fasta"
HIFIASM_FILE="/data/users/asteiner/assembly_annotation_course/assembly/hifiasm/ERR11437351.asm.bp.p_ctg.fa"

REF_GENOME="/data/courses/assembly-annotation-course/references/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa"

mkdir -p $OUTDIR

apptainer exec --bind /data $CONTAINER nucmer --prefix $OUTDIR/flyeVSref --breaklen 1000 --mincluster 1000 $REF_GENOME $FLYE_FILE

apptainer exec --bind /data $CONTAINER nucmer --prefix $OUTDIR/hifiasmVSref --breaklen 1000 --mincluster 1000 $REF_GENOME $HIFIASM_FILE

apptainer exec --bind /data $CONTAINER nucmer --prefix $OUTDIR/flyeVShifiasm --breaklen 1000 --mincluster 1000 $FLYE_FILE $HIFIASM_FILE

