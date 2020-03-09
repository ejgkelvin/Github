#!/bin/bash

#SBATCH -p short 		# partition name
#SBATCH -t 0-8:00 		# hours:minutes runlimit after which job will be killed
#SBATCH -n 6 		# number of cores requested -- this needs to be greater than or equal to the number of cores you plan to use to run your job
#SBATCH --job-name batch_bowtie2		# Job name
#SBATCH -o %j.out			# File to which standard out will be written
#SBATCH -e %j.err 		# File to which standard error will be written
#SBATCH --mail-type=END
#SBATCH --mail-user=chen_chu@hms.harvard.edu

# this `for` loop will move fastq files from every directory

for base in /n/data2/dfci/cancerbio/sicinski/raw_data/*
do
  echo "running analysis on $base"
sbatch -p short -t 0-8:00 -n 6 --job-name move_directory --wrap="sh move_directory.sh $base"
sleep 1 #wait 1 second between each job submission
done
