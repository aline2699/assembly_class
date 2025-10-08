#!/bin/bash

#SBATCH --cpus-per-task=1
#SBATCH --mem=32G
#SBATCH --time=01:00:00
#SBATCH --job-name=Busco
#SBATCH --mail-user=aline.steiner@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/asteiner/assembly_annotation_course/assembly_evaluation/BUSCO/output_busco_plot_%j.o
#SBATCH --error=/data/users/asteiner/assembly_annotation_course/assembly_evaluation/BUSCO/error_busco_plot_%j.e
#SBATCH --partition=pibu_el8


WORKDIR="/data/users/asteiner/assembly_annotation_course"
CONTAINER="/containers/apptainer/busco_6.0.0.sif"
OUTDIR="$WORKDIR/assembly_evaluation/BUSCO/plot_data"

cd $OUTDIR

apptainer exec --bind /data $CONTAINER busco --plot .