
open INPUT0,"<mouse.piRNA.fa" or die "$!";#buylist
open INPUT1,"<$ARGV[0].piRNA" or die "$!";#original data
open OUT,">$ARGV[0].piRNA.aln" or die "$!";

while (<INPUT0>) {
        chomp;
        @array=split /\s+/,$_;
        if ($array[0]=~/^>/){
            @temp=split /\>/,$array[0];
            $ID=$temp[1];
        }
        else{
          $seq{$ID}=$seq{$ID}.$_;
          }
}

my $tRNAid;
while (<INPUT1>) {
        chomp;
        @array2=split /\t/,$_;
        $totallen=length($seq{$array2[2]});
        $tlen=length($array2[9]);
        $u="";
        if ($array2[3]>1){
          for ($i=1;$i<=$array2[3];$i++){
             $u=$u."-";
          }
        }
        $u=$u.$array2[9];
        if ($tlen+$array2[3]<=$totallen){
           for ($i=1;$i<=$totallen-$tlen-$array2[3]+1;$i++){
              $u=$u."-";
           }
        }
        #if ($tlen+$array2[3]>$totallen){
        #    next;
        #}
        $u=$u."\t".$array2[0]."\t".$tlen."\t".$array2[7];
        #print $u."\n";
        push @{$tRNAid{$array2[2]}},$u;  
        #print "$array2[2]\t$u\n";
}

foreach $k (sort keys %tRNAid){
    print OUT ">".$k."\n".$seq{$k}."\t".length($seq{$k})."\n";
    while (@{$tRNAid{$k}}){
       $next= shift @{$tRNAid{$k}};
       print OUT $next."\n";
    }
}
