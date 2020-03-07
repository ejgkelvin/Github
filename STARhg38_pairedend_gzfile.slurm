#!/bin/bash

#SBATCH -p short 		# partition name
#SBATCH -t 0-12:00 		# hours:minutes runlimit after which job will be killed
#SBATCH -n 15 		# number of cores requested -- this needs to be greater than or equal to the number of cores you plan to use to run your job
#SBATCH --mem 40G
#SBATCH --job-name STAR		# Job name
#SBATCH -o %j.out			# File to which standard out will be written
#SBATCH -e %j.err 		# File to which standard error will be written
#SBATCH --mail-type=END
#SBATCH --mail-user=chen_chu@hms.harvard.edu


#load modules needed for this script
module load star/2.5.4a


#run the script
STAR --runThreadN 20 --genomeDir ~/sicinskilab/reference_data/STARgenomeHG38 \
 --readFilesCommand zcat \
 --readFilesIn 20200227_HCC1806_sgCtrl_1_CC7809_S47_R1_001.fastq.gz 20200227_HCC1806_sgCtrl_1_CC7809_S47_R2_001.fastq.gz \
 --outFileNamePrefix STARoutput/HCC1806_sgCtrl_1 \
 --outSAMstrandField intronMotif \
 --outSAMtype BAM SortedByCoordinate \
 --outFilterIntronMotifs RemoveNoncanonical \
 --outWigType wiggle --outWigNorm None \
 --quantMode TranscriptomeSAM 

