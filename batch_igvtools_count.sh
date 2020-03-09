#!/bin/bash
#initialize a variable with an intuitive name to store the name of the input fastq file
fq=$1

#grab base of file name for naming outputs
base=`basename $fq .fastq._aln.bam`
echo "Sample name is $base"

# set up the software environment
module load igvtools/2.3.98

echo "Processing file $fq"

#using igvtools/count command
igvtools count -w 25 \
$fq ~/sicinskilab/results/igvtools/$base.tdf mm9

