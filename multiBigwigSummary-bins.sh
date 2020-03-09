#!/bin/bash

# this manuscript will do multiBigwigSummary (bin mode) on the .bw files in the directory

# load modules
module load gcc/6.2.0
module load python/2.7.12
module load deeptools/2.5.3

# run multiBigwigSummary-bins
multiBigwigSummary bins --bwfiles *.bw --outFileName BigWigreadCounts.npz --outRawCounts BigWigreadCounts.tab

