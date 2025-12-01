#!/bin/bash
#SBATCH --job-name=EDTA_annotation
#SBATCH --partition=pibu_el8 
#SBATCH --cpus-per-task=40
#SBATCH --mem=128G
#SBATCH --time=2-00:00
#SBATCH --output=EDTA/logs/%x_%j.out
#SBATCH --error=EDTA/logs/%x_%j.err
# User-editable variables
WORKDIR=/data/users/asteiner/assembly_annotation_course
CONTAINER=/data/courses/assembly-annotation-course/CDS_annotation/containers/EDTA2.2.sif
INPUT_FASTA=$WORKDIR/assembly/hifiasm/ERR11437351.asm.bp.p_ctg.fa
OUTDIR=$WORKDIR/EDTA/results/EDTA_annotation

mkdir -p "$OUTDIR"
cd "$OUTDIR"

# Full run: runs TOOL_CMD inside the container using allocated CPUs
apptainer exec --bind /data \
"$CONTAINER" \
    EDTA.pl \
    --genome $INPUT_FASTA \
    --species others \
    --step all \
    --sensitive 1 \
    --cds "/data/courses/assembly-annotation-course/CDS_annotation/data/TAIR10_cds_20110103_representative_gene_model_updated" \
    --anno 1 \
    --threads 20


# OPTIONS:
# --species [Rice|Maize|others]
# Specify the species for identification of TIR candidates
#
# --step [all|filter|final|anno]
# Specify which steps you want to run EDTA.
#   all: run the entire pipeline (default)
#   filter: start from raw TEs to the end.
#   final: start from filtered TEs to finalizing the run.
#   anno: perform whole-genome annotation/analysis after TE library construction.
#
# --sensitive [0|1]	
# Use RepeatModeler to identify remaining TEs (1) or not (0,default). This step may help to recover some TEs.
#
# --anno [0|1]	
# Perform (1) or not perform (0, default) whole-genome TE annotation after TE library construction.
#   By default, EDTA does not perform a genome-wide TE annotation. Enabling this option ensures that the annotated 
#   TE sequences are output to the .gff3 file, which contains both intact and fragmented elements.
#
# --cds
# Provide a FASTA file containing the coding sequence (no introns, UTRs, nor TEs) of this genome or its close relative.
#   To ensure that gene sequences are not misclassified as TEs, you should use the --cds option with the coding 
#   sequences (CDS) file.



# OUTPUT FILES:
# Upon completion, EDTA will generate several key files that are essential for understanding the transposable 
# element landscape of your genome:
#
#   1. Non-redundant TE Library: $genome.mod.EDTA.TElib.fa
#       This FASTA file contains the transposable elements classified up to the superfamily level. The
#       sequences are labeled using the three-letter naming system from Wicker et al. (2007), and
#       each sequence represents a TE family.
#
#   2. Whole-genome TE Annotation: $genome.mod.EDTA.TEanno.gff3
#       This GFF3 file contains both intact and fragmented TE annotations across the entire genome.
# 
#   3. Intact TE Annotation: $genome.mod.EDTA.intact.gff3
#       This file lists only the structurally intact TE annotations. This can be useful for focusing on
#       recently active or well-conserved TEs.
#
#   4. Summary of Whole-genome TE Annotation: $genome.mod.EDTA.TEanno.sum
#       This file provides a summary of the annotated TEs, including counts and number of base pairs
#       in the genome per superfamily and family.
#
#   5. RepeatMasker Output: $genome.mod.EDTA.anno/$genome.mod.out
#       This output from RepeatMasker contains detailed information on TE copies, including their
#       percentage of diversity compared to the reference sequences in the TE library. The
#       percentage of diversity can be used to estimate the age of TE insertions, which is crucial for
#       understanding TE evolutionary dynamics.
