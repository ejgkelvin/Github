open INPUT0,"<$ARGV[0].all.bowtie" or die "$!";#buylist
open OUTPUT,">$ARGV[0].c" or die "$!";

#check each class

while (<INPUT0>) {
	chomp;
	@array=split /\t/,$_;
        $len=length($array[9]);
        @num=split /\-/,$array[0];
        if ($array[-1]=~/mRNA/){
          if (exists $total_count_mrna{$len}){
             $uniq_count_mrna{len}=$uniq_count_mrna{$len}+1;
             $total_count_mrna{$len}=$total_count_mrna{$len}+$num[1];
          }
          else{
              $uniq_count_mrna{$len}=1;
              $total_count_mrna{$len}=$num[1];
          }
        }
        if ($array[2]=~/rRNA/){
          if (exists $total_count_rrna{$len}){
             $uniq_count_rrna{len}=$uniq_count_rrna{$len}+1;
             $total_count_rrna{$len}=$total_count_rrna{$len}+$num[1];
          }
          else{
              $uniq_count_rrna{$len}=1;
              $total_count_rrna{$len}=$num[1];
          }
        }
        if ($array[2]=~/piRNA/ or $array[2]=~/piR-/){
          if (exists $total_count_pirna{$len}){
             $uniq_count_pirna{$len}=$uniq_count_pirna{$len}+1;
             $total_count_pirna{$len}=$total_count_pirna{$len}+$num[1];
          }
          else{
              $uniq_count_pirna{$len}=1;
              $total_count_pirna{$len}=$num[1];
          }
        }
        if ($array[-1]=~/mitoRNA/){
          if (exists $total_count_mitorna{$len}){
             $uniq_count_mitorna{$len}=$uniq_count_mitorna{$len}+1;
             $total_count_mitorna{$len}=$total_count_mitorna{$len}+$num[1];
          }
          else{
              $uniq_count_mitorna{$len}=1;
              $total_count_mitorna{$len}=$num[1];
          }
        }
        if ($array[2]=~/tRNA/){
          if (exists $total_count_trna{$len}){
             $uniq_count_trna{$len}=$uniq_count_trna{$len}+1;
             $total_count_trna{$len}=$total_count_trna{$len}+$num[1];
          }
          else{
              $uniq_count_trna{$len}=1;
              $total_count_trna{$len}=$num[1];
          }
        }
        if ($array[2]=~/microRNA/ or $array[2]=~/\;mir/ or 
            $array[2]=~/mmu-miR-/ or $array[2]=~/mmu-let-/){
          if (exists $total_count_microrna{$len}){
             $uniq_count_microrna{$len}=$uniq_count_microrna{$len}+1;
             $total_count_microrna{$len}=$total_count_microrna{$len}+$num[1];
          }
          else{
              $uniq_count_microrna{$len}=1;
              $total_count_microrna{$len}=$num[1];
          }
        }
        if ($array[2]=~/sno/  or $array[2]=~/SNO/){
          if (exists $total_count_snorna{$len}){
             $uniq_count_snorna{$len}=$uniq_count_snorna{$len}+1;
             $total_count_snorna{$len}=$total_count_snorna{$len}+$num[1];
          }
          else{
              $uniq_count_snorna{$len}=1;
              $total_count_snorna{$len}=$num[1];
          }
        }
        if ($array[2]=~/snRNA/ or $array[2]=~/\;U/){
          if (exists $total_count_snrna{$len}){
             $uniq_count_snrna{$len}=$uniq_count_snrna{$len}+1;
             $total_count_snrna{$len}=$total_count_snrna{$len}+$num[1];
          }
          else{ 
              $uniq_count_snrna{$len}=1;
              $total_count_snrna{$len}=$num[1];
          }
        }
        if ($array[9]=~/^CGCGACCTCAGATCAGACGTG/){
          if (exists $total_count_28Srna{$len}){
             $uniq_count_28Srna{$len}=$uniq_count_28Srna{$len}+1;
             $total_count_28Srna{$len}=$total_count_28Srna{$len}+$num[1];
          }
          else{
              $uniq_count_28Srna{$len}=1;
              $total_count_28Srna{$len}=$num[1];
          }
        }     
        if (exists $total_count{$len}){
             $uniq_count{$len}=$uniq_count{$len}+1;
             $total_count{$len}=$total_count{$len}+$num[1];
        }
        else{
              $uniq_count{$len}=1;
              $total_count{$len}=$num[1];
        }

}


print OUTPUT "length\tmRNA Frag\trRNA Frag\tpiRNA\tmito-sRNA\ttsRNA\t".
             "microRNA\tsno-sRNA\tsnRNA Frag\trsRNA-28S\tOther\tTotal\n";
for($i = 18; $i < 50; $i++) {
    if (exists $total_count{$i}) {
        print OUTPUT "$i\t$total_count_mrna{$i}\t$total_count_rrna{$i}\t".             
              "$total_count_pirna{$i}\t$total_count_mitorna{$i}\t".             
              "$total_count_trna{$i}\t$total_count_microrna{$i}\t".
              "$total_count_snorna{$i}\t".
              "$total_count_snrna{$i}\t".
              "$total_count_28Srna{$i}\t".
              ($total_count{$i}-$total_count_mrna{$i}-$total_count_rrna{$i}
               -$total_count_pirna{$i}-$total_count_mitorna{$i}
               -$total_count_microrna{$i}-$total_count_snorna{$i}
               -$total_count_trna{$i}-$total_count_28Srna{$i}-$total_count_snrna{$i})."\t$total_count{$i}\n";
    }
   
}

