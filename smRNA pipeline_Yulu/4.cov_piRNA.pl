
open INPUT0,"<mouse.piRNA.fa" or die "$!";#buylist
open INPUT1,"<$ARGV[0].piRNA" or die "$!";#original data
open OUT,">$ARGV[0].piRNA.cov" or die "$!";

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
        @array3 = split /\-/, $array2[0];
        $num = $array3[1];
        if (exists $tRNAid{$array2[2]}){
            $tlen=length($array2[9]);
            for ($i=$array2[3]-1;$i<$tlen;$i++){
                $tRNAid{$array2[2]}[$i]+=$num;
            }
            $tRNAnum{$array2[2]}+=$num;
        }
        else{
            my $zeroarray;
            @zeroarray = (0) x $totallen;
            @{$tRNAid{$array2[2]}} = @zeroarray;
            $tRNAnum{$array2[2]}=0;
            $tlen=length($array2[9]);
            for ($i=$array2[3]-1;$i<$tlen;$i++){
                $tRNAid{$array2[2]}[$i]+=$num;
            }
            $tRNAnum{$array2[2]}+=$num;
        }
        #print "$array2[2]\t$num\t";
        #print join("\t",@{$tRNAid{$array2[2]}}),"\n";
}



foreach $k (sort {$tRNAnum{$b} <=> $tRNAnum{$a}} keys %tRNAid){
    print OUT ">".$k."\n".$seq{$k}."\t".length($seq{$k})."\n";
    while (@{$tRNAid{$k}}){
       $next= shift @{$tRNAid{$k}};
       print OUT $next."\t";
    }
    print OUT "\n$tRNAnum{$k}\n";
}
