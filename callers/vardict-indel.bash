#!/bin/bash

bam="$1"
[[ -z "$1" ]] && { echo "Parameter 1 is empty" 1>&2; exit 1; }
peaks="$2"
[[ -z "$2" ]] && { echo "Parameter 2 is empty" 1>&2; exit 1; }
genome="$3"
[[ -z "$3" ]] && { echo "Parameter 3 is empty" 1>&2; exit 1; }
output_dir="$4"
[[ -z "$4" ]] && { echo "Parameter 4 is empty" 1>&2; exit 1; }
samp="$5"
[[ -z "$5" ]] && { echo "Parameter 5 is empty" 1>&2; exit 1; }


echo -e "CHROM\tPOS\tREF\tALT\tTYPE\tDP\tVD\tAF\tQUAL\tQSTD\tMQ\tSN\tHIAF\tADJAF\tNM\tHICNT\tHICOV\tSVTYPE\tSVLEN\tDUPRATE\tGT" > "$output_dir/vardict-indel.tsv"
vcftools --vcf "$output_dir/vardict.vcf" --keep-only-indels --recode --recode-INFO-all -c | \
bcftools query -f '%CHROM\t%POS\t%REF\t%ALT\t%INFO/TYPE\tI%NFO/DP\t%INFO/VD\t%INFO/AF\t%INFO/QUAL\t%INFO/QSTD\t%INFO/MQ\t%INFO/SN\t%INFO/HIAF\t%INFO/ADJAF\t%INFO/NM\t%INFO/HICNT\t%INFO/HICOV\t%INFO/SVTYPE\t%INFO/SVLEN\t%INFO/DUPRATE\t[%GT]\n' - >> "$output_dir/vardict-indel.tsv"
