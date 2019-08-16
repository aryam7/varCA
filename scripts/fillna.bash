#!/bin/bash

# this script replaces NA values in a large TSV with the provided replacements

# param1: the .tsv.gz file containing the large table for which we want to fill NA values
# param2+: a regex pattern for a column followed by the NA value replacement for those cols (separated by a space)
# 		   you can specify multiple column-value pairs
# return (to stdout): the same table except with only the columns specified, where all NA values have been transformed


script_dir="$(dirname "$BASH_SOURCE")";

pfiles=()
for (( i=2; i<$#; i+=2 )); do
	j=$((i+1))
	reg="${!i}"
	val="${!j}"
	pfiles+=("<(zcat \"\$1\" | \"\$script_dir\"/cgrep.bash - -E '$reg' | awk -F '\t' -v 'OFS=\t' '{{for (i=1; i<=NF; i++) if (\$i==\".\") \$i=\"$val\"}}1')")
done

eval "paste ${pfiles[@]}"
