#!/bin/bash
#initialize a variable with an intuitive name to store the name of the input fastq file
fq=$1

#grab base of file name for naming outputs
base=`basename $fq.bam`
echo "Sample name is $base"

#directory with 
genome=/n/data2/dfci/cancerbio/sicinski/reference_data/mm9

#set up output filenames and locations
align_out=/n/data2/dfci/cancerbio/sicinski/results/bowtie2/${base}_unsorted.sam
align_bam=/n/data2/dfci/cancerbio/sicinski/results/bowtie2/${base}_unsorted.bam
align_sorted=/n/data2/dfci/cancerbio/sicinski/results/bowtie2/${base}_sorted.bam
align_filetered=/n/data2/dfci/cancerbio/sicinski/results/bowtie2/${base}_aln.bam

#set up more variables for 2 additional directories to help clean up the results folder
bowtie_results=/n/data2/dfci/cancerbio/sicinski/results/bowtie2
intermediate_bams=/n/data2/dfci/cancerbio/sicinski/results/bowtie2/intermediate_bams


# set up the software environment
module load gcc/6.2.0
module load python/2.7.12  
module load deeptools/2.5.3
export PATH=/n/app/bcbio/tools/bin:$PATH 	# for using 'sambamba'

echo "Processing file $fq"

# Run bamCoverage
bamCoverage -b bowtie2/${base} \
-o visualization/bigWig/${base}.bw \
--binSize 20 \
--normalizeTo1x 130000000 \
--smoothLength 60 \
--extendReads 150 \
--centerReads \
-p 6 2> ../logs/${base}_bamCoverage.log

# Run computeMatrix
computeMatrix reference-point --referencePoint TSS \
-b 5000 -a 5000 \
-R /n/data2/dfci/sicinski/reference/*****
-S /n/data2/dfci/sicinski/results/visualization/bigWig/${base}.bw \
--skipZeros \
-o /n/data2/dfci/sicinski/results/visualization/matrix$base.gz \
--outFileSortedRegions /n/data2/dfci/sicinski/results/visualization/regions_TSS_XX.bed

# Sort BAM file by genomic coordinates
sambamba sort -t 6 -o $align_sorted $align_bam

# Filter out duplicates
sambamba view -h -t 6 -f bam -F "[XS] == null and not unmapped " $align_sorted > $align_filtered

# Move intermediate files out of the bowtie2 directory
mv $bowtie_results/${base}*sorted* $intermediate_bams
# This script takes a fastq file of ChIP-Seq data, runs FastQC and outputs a BAM file for it that is ready for peak calling. Bowtie2 is the aligner used, and the outputted BAM file is sorted by genomic coordinates and has duplicate reads removed using sambamba.
# USAGE: sh chipseq_analysis_on_input_file.sh <path to the fastq file>


