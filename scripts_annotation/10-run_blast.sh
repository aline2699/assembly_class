#!/bin/bash
#SBATCH --time=05:00:00
#SBATCH --mem=40G
#SBATCH --partition=pibu_el8
#SBATCH --cpus-per-task=20
#SBATCH --job-name=blastp3
#SBATCH --output=blast/logs/%x_%j.out
#SBATCH --error=blast/logs/%x_%j.err

WORKDIR="/data/users/asteiner/assembly_annotation_course"
UNIPROT="/data/courses/assembly-annotation-course/CDS_annotation/data/uniprot/uniprot_viridiplantae_reviewed.fa"
#MAKERPROTEIN="/data/users/asteiner/assembly_annotation_course/gene_annotation/GFF/assembly.all.maker.proteins.fasta"
MAKERPROTEIN="/data/users/asteiner/assembly_annotation_course/gene_annotation/final/longest_per_gene_protein.fa"
GENES_GFF3="/data/users/asteiner/assembly_annotation_course/gene_annotation/final/filtered.genes.renamed.gff3"
MAKERBIN="/data/courses/assembly-annotation-course/CDS_annotation/softwares/Maker_v3.01.03/src/bin"

mkdir -p $WORKDIR/blast
cd $WORKDIR/blast

module load BLAST+/2.15.0-gompi-2021a
makeblastdb -in $UNIPROT -dbtype prot # this step is already done
blastp -query $MAKERPROTEIN -db $UNIPROT -num_threads 10 -outfmt 6 -evalue 1e-5 -max_target_seqs 10 -out $WORKDIR/blast/blastp_output
# Now sort the blast output to keep only the best hit per query sequence
sort -k1,1 -k12,12g $WORKDIR/blast/blastp_output | sort -u -k1,1 --merge > $WORKDIR/blast/blastp_output.besthits

BLAST_OUTPUT="/data/users/asteiner/assembly_annotation_course/blast/blastp_output"
BLAST_BESTHITS="/data/users/asteiner/assembly_annotation_course/blast/blastp_output.besthits"

cp $MAKERPROTEIN maker_proteins.fasta.Uniprot
cp $GENES_GFF3 filtered.maker.filtered.gff3.Uniprot
$MAKERBIN/maker_functional_fasta $UNIPROT $BLAST_BESTHITS $WORKDIR/blast/maker_proteins.fasta.Uniprot > maker_proteins.filtered.fasta.Uniprot
$MAKERBIN/maker_functional_gff $UNIPROT $BLAST_OUTPUT $WORKDIR/blast/filtered.maker.filtered.gff3.Uniprot > filtered.maker.gff3.Uniprot.gff3

TAIR10_GENEMODEL="/data/courses/assembly-annotation-course/CDS_annotation/data/TAIR10_pep_20110103_representative_gene_model"

blastp -query $MAKERPROTEIN -db $TAIR10_GENEMODEL -num_threads 10 -outfmt 6 -evalue 1e-5 -max_target_seqs 10 -out $WORKDIR/blast/blastp_output_TAIR10

# Now sort the blast output to keep only the best hit per query sequence
sort -k1,1 -k12,12g $WORKDIR/blast/blastp_output_TAIR10 | sort -u -k1,1 --merge > $WORKDIR/blast/blastp_output_TAIR10.besthits
