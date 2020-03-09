open INPUT0,"<$ARGV[0].rRNA.bowtie" or die "$!";#buylist
#open INPUT1,"<$ARGV[0].fa" or die "$!";#original data
#open OUTPUT,">$ARGV[0].c" or die "$!";


while (<INPUT0>) {
	chomp;
	@array=split /\t/,$_;
        $len=length($array[9]);
        @num=split /\-/,$array[0];
        #if ($array[2]=~/^piR/){
          if (exists $totalcount{$len}){
             $uniqcount{$len}=$uniqcount{$len}+1;
             $totalcount{$len}=$totalcount{$len}+$num[1];
          }
          else{
              $uniqcount{$len}=1;
              $totalcount{$len}=$num[1];
          }
        #}

}

  foreach my $c (sort { $a <=> $b } keys %totalcount){
     print "$c\t$totalcount{$c}\t$uniqcount{$c}\n";
    }

