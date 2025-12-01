#!/bin/bash
#SBATCH --job-name=TE_sorter_Copia_Gypsy
#SBATCH --partition=pibu_el8 
#SBATCH --cpus-per-task=20
#SBATCH --mem=16G
#SBATCH --time=02:00:00
#SBATCH --output=TEsorter/logs/%x_%j.out
#SBATCH --error=TEsorter/logs/%x_%j.err
# User-editable variables
WORKDIR=/data/users/asteiner/assembly_annotation_course
CONTAINER=/data/courses/assembly-annotation-course/CDS_annotation/containers/TEsorter_1.3.0.sif
INPUT_FASTA=$WORKDIR/EDTA/results/EDTA_annotation/ERR11437351.asm.bp.p_ctg.fa.mod.EDTA.raw/ERR11437351.asm.bp.p_ctg.fa.mod.LTR.raw.fa
TELIB=/data/users/asteiner/assembly_annotation_course/EDTA/results/EDTA_annotation/ERR11437351.asm.bp.p_ctg.fa.mod.EDTA.TElib.fa
OUTDIR=$WORKDIR/TEsorter/results/

mkdir -p "$OUTDIR"
cd "$OUTDIR"

# Full run: runs TOOL_CMD inside the container using allocated CPUs
#apptainer exec --bind /data $CONTAINER TEsorter $INPUT_FASTA -db rexdb-plant

# OPTIONS:
# -db {gydb,rexdb,rexdb-plant,rexdb-metazoa,rexdb-pnas,rexdb-line,sine}
# the database name used

seqkit grep -r -p "Copia" $TELIB > Copia_sequences.fa
seqkit grep -r -p "Gypsy" $TELIB > Gypsy_sequences.fa

apptainer exec --bind /data $CONTAINER TEsorterCopia_sequences.fa -db rexdb-plant
apptainer exec --bind /data $CONTAINER TEsorterGypsy_sequences.fa -db rexdb-plant
