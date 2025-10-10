#!/bin/bash

#SBATCH --cpus-per-task=4
#SBATCH --mem=40G
#SBATCH --time=01:00:00
#SBATCH --job-name=kmer_counting
#SBATCH --mail-user=aline.steiner@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/asteiner/assembly_annotation_course/read_QC/kmer_counting/output_kmer_%j.o
#SBATCH --error=/data/users/asteiner/assembly_annotation_course/read_QC/kmer_counting/error_kmer_%j.e
#SBATCH --partition=pibu_el8

WORKDIR="/data/users/asteiner/assembly_annotation_course"
CONTAINER="/containers/apptainer/jellyfish:2.2.6--0"
OUTDIR="$WORKDIR/read_QC/kmer_counting"

apptainer exec --bind /data $CONTAINER jellyfish count -C -m 21 -s 5G -t 4 <(zcat $WORKDIR/Nemrut-1/*) -o $OUTDIR/Nemrut-1_reads.jf

apptainer exec --bind /data $CONTAINER jellyfish histo -t 4 $OUTDIR/Nemrut-1_reads.jf > $OUTDIR/Nemrut-1_reads.histo
