#!/bin/bash

#SBATCH --cpus-per-task=16
#SBATCH --mem=32G
#SBATCH --time=02:00:00
#SBATCH --job-name=mummerplot
#SBATCH --mail-user=aline.steiner@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/asteiner/assembly_annotation_course/assembly_evaluation/mummerplot/output_mummerplot_%j.o
#SBATCH --error=/data/users/asteiner/assembly_annotation_course/assembly_evaluation/mummerplot/error_mummerplot_%j.e
#SBATCH --partition=pibu_el8


WORKDIR="/data/users/asteiner/assembly_annotation_course"
CONTAINER="/containers/apptainer/mummer4_gnuplot.sif"
OUTDIR="$WORKDIR/assembly_evaluation/mummerplot"


FLYE_FILE="/data/users/asteiner/assembly_annotation_course/assembly/flye/assembly.fasta"
HIFIASM_FILE="/data/users/asteiner/assembly_annotation_course/assembly/hifiasm/ERR11437351.asm.bp.p_ctg.fa"

REF_GENOME="/data/courses/assembly-annotation-course/references/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa"

REF_DELTA="/data/users/asteiner/assembly_annotation_course/assembly_evaluation/mummerplot/refVSref.delta"


mkdir -p $OUTDIR
cd $OUTDIR

apptainer exec --bind /data $CONTAINER nucmer --prefix $OUTDIR/refVSref --breaklen 1000 --mincluster 1000 $REF_GENOME $REF_GENOME

apptainer exec --bind /data $CONTAINER mummerplot -R $REF_GENOME -Q $REF_GENOME --filter --prefix refVSref -t png --large --layout --fat $REF_DELTA


cd $WORKDIR