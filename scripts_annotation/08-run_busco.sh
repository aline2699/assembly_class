#!/bin/bash
#SBATCH --time=03:00:00
#SBATCH --mem=32G
#SBATCH --partition=pibu_el8
#SBATCH --cpus-per-task=20
#SBATCH --job-name=busco
#SBATCH --output=gene_annotation/busco/logs/%x_%j.out
#SBATCH --error=gene_annotation/busco/logs/%x_%j.err

WORKDIR="/data/users/asteiner/assembly_annotation_course/gene_annotation"
cd $WORKDIR/busco
PROTEIN="$WORKDIR/final/longest_per_gene_protein.fa"
TRANSCRIPT="$WORKDIR/final/longest_per_gene_transcript.fa"
TRINITY="/data/users/asteiner/assembly_annotation_course/trinity_out_dir.Trinity.fasta"

module load BUSCO/5.4.2-foss-2021a
busco -i $PROTEIN -l brassicales_odb10 -o busco_output_proteins -m proteins
busco -i $TRANSCRIPT -l brassicales_odb10 -o busco_output_transcriptome -m transcriptome
busco -i $TRANSCRIPT -l brassicales_odb10 -o busco_output_trinity -m transcriptome


