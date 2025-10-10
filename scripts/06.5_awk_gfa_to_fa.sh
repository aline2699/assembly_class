#!/bin/bash

#SBATCH --cpus-per-task=16
#SBATCH --mem=4G
#SBATCH --time=01:00:00
#SBATCH --job-name=awk_gfa_to_fa
#SBATCH --mail-user=aline.steiner@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/asteiner/assembly_annotation_course/assembly/hifiasm/output_gfa_to_fa_%j.o
#SBATCH --error=/data/users/asteiner/assembly_annotation_course/assembly/hifiasm/error_gfa_to_fa_%j.e
#SBATCH --partition=pibu_el8

WORKDIR="/data/users/asteiner/assembly_annotation_course"
OUTDIR="$WORKDIR/assembly/hifiasm"

awk '/^S/{print ">"$2;print $3}' $OUTDIR/ERR11437351.asm.bp.hap1.p_ctg.gfa > $OUTDIR/ERR11437351.asm.bp.hap1.p_ctg.fa
awk '/^S/{print ">"$2;print $3}' $OUTDIR/ERR11437351.asm.bp.hap1.p_ctg.noseq.gfa > $OUTDIR/ERR11437351.asm.bp.hap1.p_ctg.noseq.fa
awk '/^S/{print ">"$2;print $3}' $OUTDIR/ERR11437351.asm.bp.hap2.p_ctg.gfa > $OUTDIR/ERR11437351.asm.bp.hap2.p_ctg.fa
awk '/^S/{print ">"$2;print $3}' $OUTDIR/ERR11437351.asm.bp.hap2.p_ctg.noseq.gfa > $OUTDIR/ERR11437351.asm.bp.hap2.p_ctg.noseq.fa
awk '/^S/{print ">"$2;print $3}' $OUTDIR/ERR11437351.asm.bp.p_ctg.gfa > $OUTDIR/ERR11437351.asm.bp.p_ctg.fa
awk '/^S/{print ">"$2;print $3}' $OUTDIR/ERR11437351.asm.bp.p_ctg.noseq.gfa > $OUTDIR/ERR11437351.asm.bp.p_ctg.noseq.fa
awk '/^S/{print ">"$2;print $3}' $OUTDIR/ERR11437351.asm.bp.p_utg.gfa > $OUTDIR/ERR11437351.asm.bp.p_utg.fa
awk '/^S/{print ">"$2;print $3}' $OUTDIR/ERR11437351.asm.bp.p_utg.noseq.gfa > $OUTDIR/ERR11437351.asm.bp.p_utg.noseq.fa
awk '/^S/{print ">"$2;print $3}' $OUTDIR/ERR11437351.asm.bp.r_utg.gfa > $OUTDIR/ERR11437351.asm.bp.r_utg.fa
awk '/^S/{print ">"$2;print $3}' $OUTDIR/ERR11437351.asm.bp.r_utg.noseq.gfa > $OUTDIR/ERR11437351.asm.bp.r_utg.noseq.fa
