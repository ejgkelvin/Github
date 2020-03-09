#!/bin/bash

#SBATCH -p short                # partition name
#SBATCH -t 0-12:00              # hours:minutes runlimit after which job will be killed
#SBATCH --mem 40G
#SBATCH -n 20           # number of cores requested -- this needs to be greater than or equal to the number of cores you plan to use to run your job
#SBATCH --job-name batch_STAR           # Job name
#SBATCH -o %j.out                       # File to which standard out will be written
#SBATCH -e %j.err               # File to which standard error will be written
#SBATCH --mail-type=END
#SBATCH --mail-user=chen_chu@hms.harvard.edu

# this 'for' loop script will do STAR alignment to all the fastq files in the directory

#load modules needed for this script
module load star/2.5.4a


for fq in /home/cc452/sicinskilab/raw_data/180720_WM5583_NB501431_fastq

do
  echo "running analysis on $fq"

#initialize a variable with an intuitive name to store the name of the input fastq file
fq=$1

#run the script
STAR --runThreadN 20 --genomeDir ~/sicinskilab/reference_data/STARgenomeMouse \
 --readFilesIn /home/cc452/sicinskilab/raw_data/180720_WM5583_NB501431_fastq/$fq \
 --outFileNamePrefix /home/cc452/sicinskilab/results/STAR2.5.4a/$fq \
 --outSAMtype BAM SortedByCoordinate

sleep 1 #wait 1 second between each job submission
done
  
