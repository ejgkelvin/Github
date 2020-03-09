#!/bin/bash
#SBATCH -p short		# Partition to submit to
#SBATCH -t 0-12:00		# Time in minutes
#SBATCH -n 12                    # Number of cores requested
#SBATCH --mem=20G               # Memory total in GB (see also --mem-per-cpu)
#SBATCH -o hostname.%j.out	# Standard out goes to this file
#SBATCH -e hostname.%j.err	# Standard err goes to this file
#SBATCH --mail-type=END
#SBATCH --mail-user=chen_chu@hms.harvard.edu

#!/bin/bash
# set up the software environment
module load gcc/6.2.0
module load python/2.7.12
module load deeptools/2.5.3





bamCompare -b1 KLF4_GSM2417144.bam -b2 KLF4Input_GSM2417127.bam -o /home/cc452/sicinskilab/results/deeptools2.5.3/bamCovComp/KLF4.bw --binSize 20 --normalizeTo1x 2620345972 --smoothLength 60 --extendReads 150 --centerReads -p 12 2> /home/cc452/sicinskilab/results/deeptools2.5.3/bamCovComp/KLF4_vs_Input_bamCompare.log
