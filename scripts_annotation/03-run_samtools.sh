#!/bin/bash
#SBATCH --job-name=samtools
#SBATCH --partition=pibu_el8 
#SBATCH --cpus-per-task=20
#SBATCH --mem=64G
#SBATCH --time=2-00:00
#SBATCH --output=samtools/logs/%x_%j.out
#SBATCH --error=samtools/logs/%x_%j.err
# User-editable variables
WORKDIR=/data/users/asteiner/assembly_annotation_course
CONTAINER=/containers/apptainer/samtools-1.19.sif
INPUT_FASTA=$WORKDIR/assembly/hifiasm/ERR11437351.asm.bp.p_ctg.fa
OUTDIR=$WORKDIR/samtools/results

mkdir -p "$OUTDIR"
cd "$OUTDIR"

apptainer exec --bind /data $CONTAINER samtools faidx $INPUT_FASTA --output hifiasm_assembly.fai