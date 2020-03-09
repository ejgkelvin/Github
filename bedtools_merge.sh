#!/bin/bash
#SBATCH -p short                # partition name
#SBATCH -t 0-8:00               # hours:minutes runlimit after which job will be killed
#SBATCH -n 8           # number of cores requested -- this needs to be greater than or equal to the number of cores you plan to use to run your job
#SBATCH --mem=4G         # require more memory
#SBATCH --job-name MergeBed              # Job name
#SBATCH -o %j.out                       # File to which standard out will be written
#SBATCH -e %j.err               # File to which standard error will be written
#SBATCH --mail-type=END
#SBATCH --mail-user=chen_chu@hms.harvard.edu



# this manuscript will merge the bed files for its repetitive regions

# load modules
module load gcc/6.2.0
module load python/2.7.12
module load deeptools/2.5.3
module load bedtools/2.27.1

 mergeBed -i Mus_musculus.GRCm38.92.bed -c 1,4,5 -o distinct,distinct,distinct > Mus_musculus.GRCm38.92.merged.bed
