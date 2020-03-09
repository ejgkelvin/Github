open INPUT0,"<$ARGV[0].fa" or die "$!";#original data
#open OUTPUT,">$ARGV[0].c" or die "$!";


while (<INPUT0>) {
      chomp;
      if ($_ =~/^\>/){
	  @array=split /\-/,$_;
          $num = $array[1];
      }
      else{
          $len=length($_);
          
          if (exists $totalcount{$len}){
             $uniqcount{$len}=$uniqcount{$len}+1;
             $totalcount{$len}=$totalcount{$len}+$num;
          }
          else{
              $uniqcount{$len}=1;
              $totalcount{$len}=$num;
          }
     }

}

  foreach my $c (sort { $a <=> $b } keys %totalcount){
     print "$c\t$totalcount{$c}\n"; #\t$uniqcount{$c}\n";
    }

