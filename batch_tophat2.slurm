#!/bin/bash

#SBATCH -p short 		# partition name
#SBATCH -t 0-12:00 		# hours:minutes runlimit after which job will be killed
#SBATCH -n 10 		# number of cores requested -- this needs to be greater than or equal to the number of cores you plan to use to run your job
#SBATCH --job-name batch_tophat2		# Job name
#SBATCH -o %j.out			# File to which standard out will be written
#SBATCH -e %j.err 		# File to which standard error will be written
#SBATCH --mail-type=END
#SBATCH --mail-user=chen_chu@hms.harvard.edu

# this `for` loop, will take RNA-seq raw fastq files and perform gapped alignment to the genome using tophat2

# this script shall be placed in the raw_data file together with the batch_tophat2.sh script and the fastq files

for fq in *
do
  echo "running analysis on $fq"
sbatch -p short -t 0-12:00 -n 10 --job-name batch_tophat2 --wrap="sh batch_tophat2.sh $fq"
sleep 1 #wait 1 second between each job submission
done
