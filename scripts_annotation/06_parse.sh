#!/bin/bash

#SBATCH --job-name=parseRM
#SBATCH --partition=pibu_el8
#SBATCH --time=02:00:00
#SBATCH --mem=8G
#SBATCH --cpus-per-task=1
#SBATCH --output=/data/users/asteiner/assembly_annotation_course/R_visualizations/logs/%x_%j.out
#SBATCH --error=/data/users/asteiner/assembly_annotation_course/R_visualizations/logs/%x_%j.err

# Setting the constant for the directories and required files
WORKDIR="/data/users/asteiner/assembly_annotation_course"
INPUTDIR="$WORKDIR/EDTA/results/EDTA_annotation"
RMOUT="$INPUTDIR/ERR11437351.asm.bp.p_ctg.fa.mod.EDTA.anno/ERR11437351.asm.bp.p_ctg.fa.mod.out"
PARSER="/data/courses/assembly-annotation-course/CDS_annotation/scripts/05-parseRM.pl"
OUTDIR="$WORKDIR/R_visualizations/parseRM_results"

# Create directories
mkdir -p "$OUTDIR"

# Load the modules
module load BioPerl/1.7.8-GCCcore-10.3.0

# Run the parser (from the input directory where the .mod.out file is)
cd "$INPUTDIR" || exit 1
perl "$PARSER" -i "$RMOUT" -l 50,1 -v

# Move the result files to output directory
# mv ${GENOME}.mod.EDTA.anno/${GENOME}.mod.out.landscape.*.tab "$OUTDIR/" 2>/dev/null
mv ERR11437351.asm.bp.p_ctg.fa.mod.EDTA.anno/ERR11437351.asm.bp.p_ctg.fa.mod.out.landscape.*.tab "$OUTDIR/" 2>/dev/null
echo "Results in: $OUTDIR"