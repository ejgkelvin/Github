#!/bin/bash
#SBATCH -p short		# Partition to submit to
#SBATCH -t 0-12:00		# Time in minutes
#SBATCH -c 2                    # Number of cores requested
#SBATCH -N 1                    # Ensure that all cores are on one machine (span[hosts=1])
#SBATCH --mem=4G               # Memory total in GB (see also --mem-per-cpu)
#SBATCH -o hostname.%j.out	# Standard out goes to this file
#SBATCH -e hostname.%j.err	# Standard err goes to this file
#SBATCH --mail-type=END
#SBATCH --mail-user=chen_chu@hms.harvard.edu


for base in /n/data2/dfci/cancerbio/sicinski/results/bowtie2/*.bam
do
  echo "running analysis on $base"
sbatch -p short -t 0-8:00 -n 12 --mem 20G --job-name batch_igvtools_count --wrap="sh batch_igvtools_count.sh $base"
sleep 1 #wait 1 second between each job submission
done

