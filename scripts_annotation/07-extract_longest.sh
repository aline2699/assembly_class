#!/bin/bash
#SBATCH --time=03:00:00
#SBATCH --mem=32G
#SBATCH --partition=pibu_el8
#SBATCH --cpus-per-task=20
#SBATCH --job-name=extract_longest
#SBATCH --output=gene_annotation/final/logs/%x_%j.out
#SBATCH --error=gene_annotation/final/logs/%x_%j.err

WORKDIR="/data/users/asteiner/assembly_annotation_course/gene_annotation/final"
PROTEIN="/data/users/asteiner/assembly_annotation_course/gene_annotation/final/assembly.all.maker.proteins.fasta.renamed.filtered.fasta"
TRANSCRIPT="/data/users/asteiner/assembly_annotation_course/gene_annotation/final/assembly.all.maker.transcripts.fasta.renamed.filtered.fasta"

cd $WORKDIR
module load SeqKit/2.6.1

seqkit fx2tab $PROTEIN \
| awk -F'\t' '{len=length($2); split($1,a,"-R"); gene=a[1]; if(len>max[gene]){max[gene]=len; seq[gene]=$0}} END{for(i in seq) print seq[i]}' \
| seqkit tab2fx > longest_per_gene_protein.fa

seqkit fx2tab $TRANSCRIPT \
| awk -F'\t' '{len=length($2); split($1,a,"-R"); gene=a[1]; if(len>max[gene]){max[gene]=len; seq[gene]=$0}} END{for(i in seq) print seq[i]}' \
| seqkit tab2fx > longest_per_gene_transcript.fa

