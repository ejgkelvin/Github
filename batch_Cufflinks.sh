#!/bin/bash
bm=$1

#grab base of file name for naming outputs
base=`basename $bm Aligned.sortedByCoord.out.bam`
echo "Sample name is $base"


#load modules needed for this script
module load cufflinks/2.2.1

#run the script
 cufflinks -o ${base}_cufflinks -G /home/cc452/sicinskilab/reference_data/Mus_musculus.GRCm38.92.gtf --num-threads 20 --upper-quartile-norm --total-hits-norm $1 
