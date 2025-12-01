#!/bin/bash
#SBATCH --time=03:00:00
#SBATCH --mem=32G
#SBATCH --partition=pibu_el8
#SBATCH --cpus-per-task=20
#SBATCH --job-name=filter_annotation
#SBATCH --output=gene_annotation/final/logs/%x_%j.out
#SBATCH --error=gene_annotation/final/logs/%x_%j.err


cd gene_annotation
cd GFF
protein="assembly.all.maker.proteins.fasta"
transcript="assembly.all.maker.transcripts.fasta"
gff="assembly.all.maker.noseq.gff"
prefix="NEM1"
COURSEDIR="/data/courses/assembly-annotation-course/CDS_annotation"
MAKERBIN="$COURSEDIR/softwares/Maker_v3.01.03/src/bin"

cp $gff ../final/${gff}.renamed.gff
cp $protein ../final/${protein}.renamed.fasta
cp $transcript ../final/${transcript}.renamed.fasta
cd ../final

$MAKERBIN/maker_map_ids --prefix $prefix --justify 7 ${gff}.renamed.gff > id.map
$MAKERBIN/map_gff_ids id.map ${gff}.renamed.gff
$MAKERBIN/map_fasta_ids id.map ${protein}.renamed.fasta
$MAKERBIN/map_fasta_ids id.map ${transcript}.renamed.fasta



apptainer exec \
    --bind $COURSEDIR/data/interproscan-5.70-102.0/data:/opt/interproscan/data \
    --bind $COURSEDIR \
    --bind $SCRATCH:/temp \
    --bind /data \
    $COURSEDIR/containers/interproscan_latest.sif \
    /opt/interproscan/interproscan.sh \
    -appl pfam --disable-precalc -f TSV \
    --goterms --iprlookup --seqtype p \
    -i ${protein}.renamed.fasta -o output.iprscan


$MAKERBIN/ipr_update_gff ${gff}.renamed.gff output.iprscan > ${gff}.renamed.iprscan.gff



perl $MAKERBIN/AED_cdf_generator.pl -b 0.025 ${gff}.renamed.gff > assembly.all.maker.renamed.gff.AED.txt


perl $MAKERBIN/quality_filter.pl -s ${gff}.renamed.iprscan.gff > ${gff}_iprscan_quality_filtered.gff
# In the above command: -s Prints transcripts with an AED <1 and/or Pfam domain if in gff3


# We only want to keep gene features in the third column of the gff file
grep -P "\tgene\t|\tCDS\t|\texon\t|\tfive_prime_UTR\t|\tthree_prime_UTR\t|\tmRNA\t" ${gff}_iprscan_quality_filtered.gff > filtered.genes.renamed.gff3
# Check
cut -f3 filtered.genes.renamed.gff3 | sort | uniq


module load UCSC-Utils/448-foss-2021a
module load MariaDB/10.6.4-GCC-10.3.0
grep -P "\tmRNA\t" filtered.genes.renamed.gff3 | awk '{print $9}' | cut -d ';' -f1 | sed 's/ID=//g' > list.txt
faSomeRecords ${transcript}.renamed.fasta list.txt ${transcript}.renamed.filtered.fasta
faSomeRecords ${protein}.renamed.fasta list.txt ${protein}.renamed.filtered.fasta