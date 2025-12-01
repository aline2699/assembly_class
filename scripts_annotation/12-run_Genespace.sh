#!/bin/bash
#SBATCH --time=05:00:00
#SBATCH --mem=40G
#SBATCH --partition=pibu_el8
#SBATCH --job-name=pangenome_c
#SBATCH --output=GENESPACE/logs/%x_%j.out
#SBATCH --error=GENESPACE/logs/%x_%j.err

WORKDIR="/data/users/asteiner/assembly_annotation_course"
genespaceR="/data/users/asteiner/assembly_annotation_course/scripts_annotation/11-GENESPACE.R"
pangenomeR="/data/users/asteiner/assembly_annotation_course/scripts_annotation/riparian_plots.R"
CONTAINER="/data/courses/assembly-annotation-course/CDS_annotation/containers/genespace_latest.sif"

cd $WORKDIR/GENESPACE
#apptainer exec --bind /data --bind $SCRATCH:/temp $CONTAINER Rscript $genespaceR $WORKDIR/GENESPACE/genespace_WD
apptainer exec --bind /data --bind $SCRATCH:/temp $CONTAINER Rscript $pangenomeR $WORKDIR/GENESPACE/genespace_WD