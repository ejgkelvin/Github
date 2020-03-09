#!/bin/bash/

#This script will take files out of their current directory and rename the files with the name of the directory
#Usage: sh move_directory.sh <path to the fastq files>

#initialize a variable with an intuitive name to store the name of the input fastq files
directory=$1 

#confirm the name
base=`basename /n/data2/dfci/cancerbio/sicinski/raw_data/$directory`
echo "Sample name is $base"

#Run Copy file
cp /n/data2/dfci/cancerbio/sicinski/raw_data/${base}/*merge* /n/data2/dfci/cancerbio/sicinski/raw_data/${base}.fastq

#End
