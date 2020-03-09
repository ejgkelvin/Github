#use Math::BigNum;
$file = @ARGV[0];#seq1
open INPUT0,"$file.all.bowtie" or die "$!";
open OUTPUT,">$file.sum.txt" or die "$!";

$total = 0.0;
foreach $line (<INPUT0>) {
        chomp($line);
        @temp=split /\t/,$line;
        $ID=$temp[0];
        @count = split /\-/,$ID;
        $totalcount = $count[1];
        $total += $totalcount;
                  if(exists $count1{$temp[2]}){
                      $count1{$temp[2]}+=$totalcount+0.0;
                      $top1{$temp[2]}=$top1{$temp[2]}.",".$ID;
                  }
                  else{
                      $count1{$temp[2]}=$totalcount+0.0;
                      $top1{$temp[2]}=$ID;
                  }
}

close INPUT0;


foreach my $c (sort { $count1{$b} <=> $count1{$a} } keys %count1){
    $ratio = ($count1{$c}+0.0)/($total+0.0);
    print OUTPUT "$c\t$ratio\t$top1{$c}\n";
    # print "$c\t$count1{$c}\n";
}

