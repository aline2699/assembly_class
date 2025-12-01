#!/bin/bash
#SBATCH --time=02:00:00
#SBATCH --mem=32G
#SBATCH --partition=pibu_el8
#SBATCH --cpus-per-task=20
#SBATCH --job-name=merge_GFF
#SBATCH --output=gene_annotation/GFF/logs/%x_%j.out
#SBATCH --error=gene_annotation/GFF/logs/%x_%j.err


WORKDIR=/data/users/asteiner/assembly_annotation_course/gene_annotation/GFF
cd $WORKDIR

COURSEDIR="/data/courses/assembly-annotation-course/CDS_annotation"

DATASTORE_INDEX="/data/users/asteiner/assembly_annotation_course/gene_annotation/MAKER/ERR11437351.asm.bp.p_ctg.maker.output/ERR11437351.asm.bp.p_ctg_master_datastore_index.log"

MAKERBIN="$COURSEDIR/softwares/Maker_v3.01.03/src/bin"
$MAKERBIN/gff3_merge -s -d $DATASTORE_INDEX > assembly.all.maker.gff
$MAKERBIN/gff3_merge -n -s -d $DATASTORE_INDEX > assembly.all.maker.noseq.gff
$MAKERBIN/fasta_merge -d $DATASTORE_INDEX -o assembly




