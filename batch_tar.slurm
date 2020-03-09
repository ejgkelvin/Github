#!/bin/bash

#SBATCH -p short 		# partition name
#SBATCH -t 0-12:00 		# hours:minutes runlimit after which job will be killed
#SBATCH --mem 40G
#SBATCH -n 20 		# number of cores requested -- this needs to be greater than or equal to the number of cores you plan to use to run your job
#SBATCH --job-name batch_command		# Job name
#SBATCH -o %j.out			# File to which standard out will be written
#SBATCH -e %j.err 		# File to which standard error will be written
#SBATCH --mail-type=END
#SBATCH --mail-user=chen_chu@hms.harvard.edu

# this 'for' loop script will do tar.gz to all the folders in the directory

#for fq in /home/cc452/sicinskilab/raw_data/

#do
  echo "running analysis on Chen"
  tar -zcvf Chen.tar.gz Chen/ 
#sleep 1 #wait 1 second between each job submission
#done

