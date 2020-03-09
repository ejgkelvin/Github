#!/bin/bash

# this script shall be put and run in ~/sicinski/raw_data/ directory together with the samename.slurm script and the fastq files

#give a intuitive name to $1
Protein=$1

#grab base of file name for naming outputs
base=`basename $Protein .fastq.gz`
echo "Sample name is $base"

# set up the software environment
module load gcc/6.2.0
module load bowtie2/2.2.9  
module load tophat/2.1.1 

# Run tophat2
tophat ~/sicinskilab/reference_data/mm9 $1 

#End
