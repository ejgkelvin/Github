#!/bin/bash

#SBATCH -p short 		# partition name
#SBATCH -t 0-8:00 		# hours:minutes runlimit after which job will be killed
#SBATCH -n 4 		# number of cores requested -- this needs to be greater than or equal to the number of cores you plan to use to run your job
#SBATCH --job-name batch_htseq-count-submit		# Job name
#SBATCH -o %j.out			# File to which standard out will be written
#SBATCH -e %j.err 		# File to which standard error will be written
#SBATCH --mail-type=END
#SBATCH --mail-user=chen_chu@hms.harvard.edu

# this `for` loop, will take STAR mapped bam files as input and output htseq-count files


for sample in *.bam
do
  echo "running analysis on $sample"
sbatch -p short -t 0-8:00 -n 10 --job-name batch_htseq-count --wrap="sh batch_htseq-count.sh $sample"
sleep 1 #wait 1 second between each job submission
done
