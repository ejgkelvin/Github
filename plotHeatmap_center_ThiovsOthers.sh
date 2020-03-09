#!/bin/bash

# this manuscript will do plotProfile on the .gz files in the directory

# load modules
module load gcc/6.2.0
module load python/2.7.12
module load deeptools/2.5.3

# run plotHeatmap
 plotHeatmap -m matrix_ThiovsH3K9_ThioPeakCenter_5k.gz -out ThiovsOthers_ThioPeakCenter5k.pdf --colorMap RdBu_r --plotTitle "AllThioPeaks" --legendLocation none -y TPM --yMax 2.5 0.15 6 3.5 1.7 --yMin -0.2 -0.02 -0.2 -0.2 -0.2 --refPointLabel PeakCenter --regionsLabel ThioPeakRegions --samplesLabel H3K4me3 H3K9me3 KDM4A KDM4C Thio --boxAroundHeatmaps yes -x PeakLength --heatmapWidth 8



