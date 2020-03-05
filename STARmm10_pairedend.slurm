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
STAR --runThreadN 20 --genomeDir ~/sicinskilab/reference_data/STARgenomeMM10 \
 --readFilesIn CreKO_Rep3_1.fastq CreKO_Rep3_2.fastq \
 --outFileNamePrefix STARoutput/CreKO_Rep3 \
 --outSAMstrandField intronMotif \
 --outSAMtype BAM SortedByCoordinate \
 --outFilterIntronMotifs RemoveNoncanonical \
 --outWigType wiggle --outWigNorm None \
 --quantMode TranscriptomeSAM 

