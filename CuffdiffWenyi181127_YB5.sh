#!/bin/bash

#this script will do cuffdiff on the following bam files

#load modules needed for this script
module load cufflinks/2.2.1

#run the script
 cuffdiff /home/cc452/sicinskilab/reference_data/Homo_sapiens.GRCh38.94.gtf \
 -L Ctrl,Depsi --num-threads 20 --upper-quartile-norm --total-hits-norm \
YB5_Ctrl_1.fastqAligned.sortedByCoord.out.bam,YB5_Ctrl_2.fastqAligned.sortedByCoord.out.bam,YB5_Ctrl_3.fastqAligned.sortedByCoord.out.bam \
YB5_Depsi_1.fastqAligned.sortedByCoord.out.bam,YB5_Depsi_2.fastqAligned.sortedByCoord.out.bam,YB5_Depsi_3.fastqAligned.sortedByCoord.out.bam \
-o ./YB5_Diff

