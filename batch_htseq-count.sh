#!/bin/bash
#initialize a variable with an intuitive name to store the name of the input bam file
sample=$1

#grab base of file name for naming outputs
base=`basename $sample .fastqAligned.sortedByCoord.out.bam`
echo "Sample name is $base"

# set up the software environment
module load gcc/6.2.0  
module load python/2.7.12
module load htseq/0.9.1

echo "Processing file $fq"

# Run htseq-count
 htseq-count --mode=union --stranded=no --additional-attr=gene_name --quiet -f bam $sample Mus_musculus.GRCm38.92.gtf -o $base_count.txt



