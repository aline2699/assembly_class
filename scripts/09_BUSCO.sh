#!/bin/bash

#SBATCH --cpus-per-task=8
#SBATCH --mem=128G
#SBATCH --time=02:00:00
#SBATCH --job-name=Busco
#SBATCH --mail-user=aline.steiner@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/asteiner/assembly_annotation_course/assembly_evaluation/BUSCO/output_busco_%j.o
#SBATCH --error=/data/users/asteiner/assembly_annotation_course/assembly_evaluation/BUSCO/error_busco_%j.e
#SBATCH --partition=pibu_el8


WORKDIR="/data/users/asteiner/assembly_annotation_course"
CONTAINER="/containers/apptainer/busco_6.0.0.sif"
OUTDIR="$WORKDIR/assembly_evaluation/BUSCO"
FLYE_FILE="/data/users/asteiner/assembly_annotation_course/assembly/flye/assembly.fasta"
HIFIASM_FILE="/data/users/asteiner/assembly_annotation_course/assembly/hifiasm/ERR11437351.asm.bp.p_ctg.fa"
TRINITY_FILE="/data/users/asteiner/assembly_annotation_course/trinity_out_dir.Trinity.fasta"

mkdir -p $OUTDIR/flye
mkdir -p $OUTDIR/hifiasm
mkdir -p $OUTDIR/trinity



apptainer exec --bind /data $CONTAINER busco -i $FLYE_FILE -m 'genome' -c 8 -l /data/users/asteiner/assembly_annotation_course/brassicales_odb10 --out_path $OUTDIR -o flye --offline -f
apptainer exec --bind /data $CONTAINER busco -i $HIFIASM_FILE -m 'genome' -c 8 -l /data/users/asteiner/assembly_annotation_course/brassicales_odb10 --out_path $OUTDIR -o hifiasm --offline -f
apptainer exec --bind /data $CONTAINER busco -i $TRINITY_FILE -m 'genome' -c 8 -l /data/users/asteiner/assembly_annotation_course/brassicales_odb10 --out_path $OUTDIR -o trinity --offline -f
