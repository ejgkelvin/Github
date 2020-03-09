#!/bin/bash
#initialize a variable with an intuitive name to store the name of the input fastq file
fq=$1

#grab base of file name for naming outputs
base=`basename $fq .fastqAligned.sortedByCoord.out.bam`
echo "Sample name is $base"

#load modules needed for this script
module load cufflinks/2.2.1

#run the script
cufflinks $fq \
 --GTF /home/cc452/sicinskilab/reference_data/Mus_musculus.GRCm38.92.gtf \
 -p 8 \
 --upper-quartile-norm \
 --multi-read-correct \
 -o ./$base
     
