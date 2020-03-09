#!/bin/bash

# Paste this script in the folder where all the raw fastq files are. Create a $name.list containing the name all the raw fastq files before running this script. 

module load gcc/6.2.0
module load perl/5.24.0
module load bowtie2/2.2.9

cat name.list | while read i; do

    #fastq_quality_filter -q 13 -p 15 -Q33 -i $i.fastq |fastx_clipper -v -l 18 -Q33 -a TGGAATTCTCGGGTGCCAAGG -c -o $i\_3.fq
    #awk '{if(NR%4==2) print length($1)}' $i\_3.fq | sort -n | uniq -c > $i\_3.len
    #fastx_collapser -Q33 -i $i\_3.fq  |awk 'NR%2==0 {gsub(/NN.*$/,"");} {print}' |awk 'NR%2==0 {gsub(/^N/,"");} {print}' > $i.fa


# Perform alignment to both the reference genome and the reference known transcripts
    bowtie2 -p 8 --end-to-end -x /n/data2/dfci/cancerbio/sicinski/reference_data/mm9 -f -U $i.fa -S $i.sam --al $i.map --un $i.unmap
    bowtie2 -p 8 --end-to-end -x /n/data2/dfci/cancerbio/sicinski/reference_data/0.43.1/Mus_musculus.GRCm38.cdna.all.fa.gz  -f -U $i.unmap -S $i.transcript.sam --al $i.transcript.map --un $i.transcript.unmap


    awk '{if(NR%2==0) print length($1)}' $i.fa | sort -n | uniq -c > $i.len
    sed '0~2d' $i.fa |awk 'BEGIN{FS="-"; ORS="\n";sum=0}{sum+=$2} END {print sum}' > $i.totallen

    # add ensembl transcript mapped reads to genome mm10 mapped reads
    paste $i.transcript.map >> $i.map
    awk '{if(NR%2==0) print length($1)}' $i.map | sort -n | uniq -c > $i.map.len
    sed '0~2d' $i.map |awk 'BEGIN{FS="-"; ORS="\n";sum=0}{sum+=$2} END {print sum}'>$i.map.totallen

    bowtie2 -p 8 --end-to-end -x /home/yulu/database/Mus_musculus/smRNA/mouse.mirbase -f -U $i.map -S $i.mirbase.sam --al $i.mirbase.map --un $i.mirbase.unmap
    bowtie2 -p 8 --end-to-end -x /home/yulu/database/Mus_musculus/smRNA/mouse.Rfam -f -U $i.mirbase.unmap -S $i.Rfam.sam --al $i.Rfam.map --un $i.Rfam.unmap
    bowtie2 -p 8 --end-to-end -x /home/yulu/database/Mus_musculus/smRNA/mouse.piRNA -f -U $i.Rfam.unmap -S $i.piRNA.sam --al $i.piRNA.map --un $i.piRNA.unmap
    bowtie2 -p 8 --end-to-end -x /home/yulu/database/Mus_musculus/smRNA/mouse.genbank -f -U $i.piRNA.unmap -S $i.genbank.sam --al $i.genbank.map --un $i.genbank.unmap



    samtools view -S -F 0x4 $i.mirbase.sam > $i.mirbase
    samtools view -S -F 0x4 $i.Rfam.sam > $i.Rfam
    samtools view -S -F 0x4 $i.piRNA.sam > $i.piRNA
    samtools view -S -F 0x4 $i.genbank.sam > $i.genbank

    perl 2.class.bowtie.pl $i


    cat $i.mirbase $i.Rfam $i.piRNA $i.genbank.f | sort -n > $i.all.bowtie

        echo $i
	grep "mRNA" $i.all.bowtie |wc -l
	grep "rRNA" $i.all.bowtie |grep -v "CGCGACCTCAGATCAGACGTG" | wc -l
	grep -E "piRNA|piR-" $i.all.bowtie |grep -v "CGCGACCTCAGATCAGACGTG" | wc -l
	grep "mitoRNA" $i.all.bowtie |wc -l
	grep "tRNA" $i.all.bowtie |wc -l
	grep -E "microRNA|;mir|mmu-miR-|mmu-let-" $i.all.bowtie |wc -l
	grep -E "sno|SNO|snoRNA" $i.all.bowtie |wc -l
	grep -E "snRNA|;U" $i.all.bowtie |wc -l
        #grep -E "28SrRNA" $i.all.bowtie |wc -l
        #grep -E "18SrRNA" $i.all.bowtie |wc -l
        awk '$10~/^CGCGACCTCAGATCAGACGTG/'  $i.all.bowtie |wc -l
	echo "x"
	wc -l $i.all.bowtie
	echo "y"

	grep "mRNA" $i.all.bowtie |cut -f 1|awk 'BEGIN{FS="-"; ORS="\n";sum=0}{sum+=$2} END {print sum}' 
	grep "rRNA" $i.all.bowtie |grep -v "CGCGACCTCAGATCAGACGTG" |cut -f 1|awk 'BEGIN{FS="-"; ORS="\n";sum=0}{sum+=$2} END {print sum}' 
	grep -E "piRNA|piR-" $i.all.bowtie |grep -v "CGCGACCTCAGATCAGACGTG" |cut -f 1|awk 'BEGIN{FS="-"; ORS="\n";sum=0}{sum+=$2} END {print sum}' 
	grep "mitoRNA" $i.all.bowtie |cut -f 1|awk 'BEGIN{FS="-"; ORS="\n";sum=0}{sum+=$2} END {print sum}' 
	grep "tRNA" $i.all.bowtie |cut -f 1|awk 'BEGIN{FS="-"; ORS="\n";sum=0}{sum+=$2} END {print sum}' 
	grep -E "microRNA|;mir|mmu-miR-|mmu-let-" $i.all.bowtie |cut -f 1|awk 'BEGIN{FS="-"; ORS="\n";sum=0}{sum+=$2} END {print sum}' 
	grep -E "sno|SNO|snoRNA" $i.all.bowtie |cut -f 1|awk 'BEGIN{FS="-"; ORS="\n";sum=0}{sum+=$2} END {print sum}' 
	grep -E "snRNA|;U" $i.all.bowtie |cut -f 1|awk 'BEGIN{FS="-"; ORS="\n";sum=0}{sum+=$2} END {print sum}' 
	#grep -E "28SrRNA" $i.all.bowtie |cut -f 1|awk 'BEGIN{FS="-"; ORS="\n";sum=0}{sum+=$2} END {print sum}'
        #grep -E "18SrRNA" $i.all.bowtie |cut -f 1|awk 'BEGIN{FS="-"; ORS="\n";sum=0}{sum+=$2} END {print sum}'
        awk '$10~/^CGCGACCTCAGATCAGACGTG/'  $i.all.bowtie |cut -f 1|awk 'BEGIN{FS="-"; ORS="\n";sum=0}{sum+=$2} END {print sum}'     
    
        echo "x"
	cut -f 1 $i.all.bowtie|awk 'BEGIN{FS="-"; ORS="\n";sum=0}{sum+=$2} END {print sum}'
	echo "y"

done
