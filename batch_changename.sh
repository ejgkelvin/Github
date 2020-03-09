#!/bin/bash
#initialize a variable with an intuitive name to store the name of the input fastq file
fq=$1

#grab base of file name for naming outputs
base=`basename $fq .fastq._aln.bam`
echo "Sample name is $base"

mv $fq $base.bam

# This script changes the name of a particular file. 


