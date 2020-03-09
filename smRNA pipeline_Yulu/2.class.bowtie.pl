open INPUT0,"<mouse.RNA.profile " or die "$!";#buylist
open INPUT1,"<$ARGV[0].genbank" or die "$!";#original data
open OUTPUT,">$ARGV[0].genbank.f" or die "$!";

while (<INPUT0>) {
	chomp;
	@array=split /\t/,$_;
	$summit{$array[0]}=$array[1];

}

while (<INPUT1>) {
        chomp;
        @array2=split /\t/,$_;
            if (exists $summit{$array2[2]}){
                 print OUTPUT "$_\t$summit{$array2[2]}\n"; 
            }
            else{
                 print OUTPUT "$_\tunknown\n";
            }
}
