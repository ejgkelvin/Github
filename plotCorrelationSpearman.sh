#!/bin/bash

# this manuscript will do plotCorrelation Spearman Method

# load modules
module load gcc/6.2.0
module load python/2.7.12
module load deeptools/2.5.3

# run plotCorrelation Pearson
 plotCorrelation -in BigWigreadCounts_allgenes500bp+-summits.npz --corMethod spearman --skipZeros --plotTitle "Spearman_all_genes_summit500bp" --whatToPlot heatmap --colorMap RdYlBu_r -o heatmap_SpearmanCorr_all_genes_summit500bp.pdf --outFileCorMatrix SpearmanCorr_all_genes_summit500bp.tab
