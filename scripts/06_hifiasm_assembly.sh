#!/bin/bash

#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=hifiasm_assembly
#SBATCH --mail-user=aline.steiner@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/asteiner/assembly_annotation_course/assembly/hifiasm/output_fastqc_%j.o
#SBATCH --error=/data/users/asteiner/assembly_annotation_course/assembly/hifiasm/error_fastqc_%j.e
#SBATCH --partition=pibu_el8

WORKDIR="/data/users/asteiner/assembly_annotation_course"
CONTAINER="/containers/apptainer/hifiasm_0.25.0.sif"
OUTDIR="$WORKDIR/assembly/hifiasm"
FILE="/data/users/asteiner/assembly_annotation_course/Nemrut-1/ERR11437351.fastq.gz"


mkdir -p $OUTDIR


apptainer exec --bind /data $CONTAINER hifiasm -o ERR11437351.asm -t 16 $FILE

awk '/^S/{print ">"$2;print $3}' ERR11437351.asm.bp.p_ctg.gfa > ERR11437351.asm.bp.p_ctg.fa
