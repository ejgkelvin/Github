#!/bin/bash

#SBATCH -p short 		# partition name
#SBATCH -t 0-12:00 		# hours:minutes runlimit after which job will be killed
#SBATCH --mem 40G
#SBATCH -n 20 		# number of cores requested -- this needs to be greater than or equal to the number of cores you plan to use to run your job
#SBATCH --job-name STARgenomeGenerate		# Job name
#SBATCH -o %j.out			# File to which standard out will be written
#SBATCH -e %j.err 		# File to which standard error will be written
#SBATCH --mail-type=END
#SBATCH --mail-user=chen_chu@hms.harvard.edu

# this script will generate a reference genome used for STAR alignment

#load modules needed for this script
module load star/2.5.4a

#run the script
STAR --runMode genomeGenerate --runThreadN 20 --limitGenomeGenerateRAM 40043040000 --genomeDir STARgenomeHG38 \
 --genomeFastaFiles GRCh38.p13.genome.fa --sjdbGTFfile gencode.v32.chr_patch_hapl_scaff.annotation.gtf  \
 --sjdbOverhang 100 --genomeChrBinNbits 15

