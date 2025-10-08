#!/bin/bash

#SBATCH --cpus-per-task=16
#SBATCH --mem=32G
#SBATCH --time=02:00:00
#SBATCH --job-name=Quast
#SBATCH --mail-user=aline.steiner@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/asteiner/assembly_annotation_course/assembly_evaluation/QUAST/output_quast_%j.o
#SBATCH --error=/data/users/asteiner/assembly_annotation_course/assembly_evaluation/QUAST/error_quast_%j.e
#SBATCH --partition=pibu_el8


WORKDIR="/data/users/asteiner/assembly_annotation_course"
CONTAINER="/containers/apptainer/quast_5.2.0.sif"
OUTDIR="$WORKDIR/assembly_evaluation/QUAST"

FLYE_FILE="/data/users/asteiner/assembly_annotation_course/assembly/flye/assembly.fasta"
HIFIASM_FILE="/data/users/asteiner/assembly_annotation_course/assembly/hifiasm/ERR11437351.asm.bp.p_ctg.fa"

REF_GENOME="/data/courses/assembly-annotation-course/references/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa"
FEATURE_FILE="/data/courses/assembly-annotation-course/references/Arabidopsis_thaliana.TAIR10.57.gff3"

mkdir -p $OUTDIR/no_ref
mkdir -p $OUTDIR/ref



#apptainer exec --bind /data $CONTAINER quast.py -o $OUTDIR/flye -r $REF_GENOME -g gene:$FEATURE_FILE -t 4 -e --large -l flye_with_reference $FLYE_FILE

#apptainer exec --bind /data $CONTAINER quast.py -o $OUTDIR/flye --est-ref-size 125000000 -g gene:$FEATURE_FILE -t 4 -e --large -l hifiasm_no_reference $FLYE_FILE 

#apptainer exec --bind /data $CONTAINER quast.py -o $OUTDIR/hifiasm -r $REF_GENOME -g gene:$FEATURE_FILE -t 4 -e --large -l hifiasm_with_reference $HIFIASM_FILE

#apptainer exec --bind /data $CONTAINER quast.py -o $OUTDIR/hifiasm --est-ref-size 125000000 -g gene:$FEATURE_FILE -t 4 -e --large -l hifiasm_no_reference $HIFIASM_FILE 
# === Run QUAST without reference ===
#apptainer exec --bind /data $CONTAINER quast.py $FLYE_FILE $HIFIASM_FILE --eukaryote --threads 4 --est-ref-size 125000000 -g gene:$FEATURE_FILE --labels Flye,Hifiasm -o $OUTDIR/no_ref

# === Run QUAST with reference ===
apptainer exec --bind /data $CONTAINER quast.py $FLYE_FILE $HIFIASM_FILE --eukaryote --threads 4 --est-ref-size 125000000 -g gene:$FEATURE_FILE --labels Flye,Hifiasm -R $REF_GENOME --features $FEATURE_FILE -o $OUTDIR/ref
