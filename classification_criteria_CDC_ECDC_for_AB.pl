#!/usr/bin/perl -w #warning mode
use Text::CSV_XS; #(Load the module by written this) comma-separated values manipulation routines

#use of checkdr( 'cat no.', 'min', 'max', 'row values' )
sub checkdr{
my $num= $_[0]; #the first argument (for category number 2,5,7,14,17 etc)
my $min= $_[1]; #the second argument
my $max= $_[2]; #the III argument
my $row= $_[3][$num]; #the IV argument (row values)
#print "$row \n";
#print "$num, $row, \n";
my $sus=0, my $dr=0, my $na=0; #count numbers of NA, DR and susceptible
	while($num>=$min && $num<=$max){
		my $row= $_[3][$num]; #read data row wise from 3rd row
	#print "$num \t, $row,\n";	
			if ($row eq "Susceptible") {
				#print "\t\tprint Susceptible\t";
				$sus=$sus+1;
				#$sus=1;
			}
			elsif ($row eq "Resistant") {
				#print "\t\tprint Resistant\t";
				$dr=$dr+1;
				#$dr=1;
			}
			elsif ($row eq "NA") {
				#print "\t\tprint NA\t";
				$na=$na+1;
				#$na=1;
			}
			else{
				#print "\t\tCheck data\t";
				#print "";
				
			}
		$num=$num+1;
		# print "checkdr cat: $sus\t,$dr\t,$na\n"
		}
		#	print ("'check', $sus\t,$dr\t,$na\n");
		$flag_a=0; # all antibiotic are drug resistant
		$flag_s=0; # all antibiotic are drug susceptible
		$flag_d=0; # data not in the category
		$flag_n=0; # previous conditions are not satisfied
		#$ab_count= $max-$min+1 ; # antibiotic count in category
		
		if ($dr >=1){
			$flag_a=1; # at least one resistant in category including only 1 drug in 1 category
		}
		elsif ($sus >=1 ){
			$flag_s=1; # at least one sus in category 
		}
		elsif ($na >=1 ){
			$flag_n=1; # check at least 1 NA in category
		}
		else {
			$flag_d=1; # data is not in category
		}
		
		#print ("Flags ab: $ab_count, s: $flag_s, d: $flag_d, n: $flag_n, a:$flag_a,"\n");
		
	#return($sus,$dr,$na);
	return ($flag_s,$flag_d,$flag_n,$flag_a);

}


my $csv = Text::CSV_XS->new; #comma-separated values manipulation routines

open (DATA, "<812_input_paperwise.csv"); # read mode 
#open (DATA, "<18_for_classification.csv"); # read mode 

#open (DATA, "<strain3.csv"); # read mode 
#open (DATA, "<xdr19.csv"); # read mode 
open (OUTPUT, ">812_output_paperwise.csv"); #write mode
#open (OUTPUT, ">18_for_classification_output"); #write mode


while(my $row = $csv->getline(DATA)) { #read csv file line by line
	#print "$row->[0]\t$row->[1]\t";
	my $tr=0; # total resistant flag count
	my $dr=0; # initiate drug resistance flag count
	my $mdr=0; #initialise values of MDR
	my $xdr=0; #initialise values of XDR
	my $tdr=0; #initialise values of TDR
	my $sus=0; #initialise values of sus flag couns
	my $na = 0;	#initialise values of na flag count
	my $num = 2;	#starting from 2nd coloumns
	my $polymyxin_sus = 0 ; # special case of polymyxin_sus as XDR
	#print "$na";
# cat 1
	my $min = 2; my $max = 4; #starting from 2nd to 4th coloumns
	@cat=&checkdr($num,$min,$max,$row); #output array to array assignment
	$sus=$sus+$cat[0]; $dr=$dr+$cat[1]; $na=$na+$cat[2];$tr=$tr+$cat[3]; 
	#print "$dr";
	
# cat 2
	$min = 5; $max = 7; $num = $min; #starting from 5th to 7th coloumns
	@cat=&checkdr($num,$min,$max,$row);
	$sus=$sus+$cat[0]; $dr=$dr+$cat[1]; $na=$na+$cat[2];$tr=$tr+$cat[3];
	
# cat 3
	$min = 8; $max = 9;$num = $min; #starting from 8th to 9th coloumns
	@cat=&checkdr($num,$min,$max,$row);
	$sus=$sus+$cat[0]; $dr=$dr+$cat[1]; $na=$na+$cat[2];$tr=$tr+$cat[3];
	
# cat 4
	$min = 10; $max = 11;$num = $min; #starting from 2nd to 4th coloumns
	@cat=&checkdr($num,$min,$max,$row);
	$sus=$sus+$cat[0]; $dr=$dr+$cat[1]; $na=$na+$cat[2];$tr=$tr+$cat[3];
# cat 5
	$min = 12; $max = 15; $num=$min; #starting from 2nd to 4th coloumns
	@cat=&checkdr($num,$min,$max,$row);
	$sus=$sus+$cat[0]; $dr=$dr+$cat[1]; $na=$na+$cat[2];$tr=$tr+$cat[3];
# cat 6
	$min = 16; $max = 16; $num=$min; #starting from 2nd to 4th coloumns
	@cat=&checkdr($num,$min,$max,$row);
	$sus=$sus+$cat[0]; $dr=$dr+$cat[1]; $na=$na+$cat[2];$tr=$tr+$cat[3];
# cat 7
	$min = 17; $max = 17; $num=$min; #starting from 2nd to 4th coloumns
	@cat=&checkdr($num,$min,$max,$row);
	$sus=$sus+$cat[0]; $dr=$dr+$cat[1]; $na=$na+$cat[2];$tr=$tr+$cat[3];
	
# cat 8
	$min = 18; $max = 19; $num=$min; #starting from 2nd to 4th coloumns
	@cat=&checkdr($num,$min,$max,$row);
	$polymyxin_sus=$cat[0]; $sus=$sus+$cat[0]; $dr=$dr+$cat[1]; $na=$na+$cat[2];$tr=$tr+$cat[3];
	#print "test1:  $polymyxin_sus\n";

# cat 9
	$min = 20; $max = 22; $num=$min; #starting from 2nd to 4th coloumns
	@cat=&checkdr($num,$min,$max,$row);
	$sus=$sus+$cat[0]; $dr=$dr+$cat[1]; $na=$na+$cat[2];$tr=$tr+$cat[3];

	#check code for loop
	# print "check condition flags : sus: $sus, dr: $dr, na: $na, tr: $tr\n";
	## if( $na==0){print "print 9 values $row->[0],\t\t$num, $sus, $dr, $na,$tr \n";	}
	
	## for Susceptible, all category must have at least one agent of suseptible but no Resistantagent within category.
	if($row->[1] eq 'Resistance_phenotype'){
		#print "";
	}	
	#elsif($sus>=7 && $sus<=9 && $tr==0 && $na>=0){
	elsif($sus<=9 && $tr==0 && $na>=0 && $dr==0){
		$row->[1] = 'Possible Susceptible';
		
	}
	

	# $dr and $tr are mutually exclusive case so we need to sum it to find resistant case count in categories (sequence of condition is important because it overwrite the variable values $row[1])	
	#elsif($tr>=3 && $tr<7 && $sus>=0 && $na>=0 ){


	elsif($tr>=3 && $tr<7 && $na>=0 && $sus>=0 ){
		$row->[1] = 'Possible MDR';
	}
		elsif($polymyxin_sus == 1 && $tr>=1){    
                $row->[1] = 'Possible XDR';
		#print "$polymyxin_sus\n";
    } 
        
	#elsif($tr>=7 && $tr<9 && $na>=0 && $sus>=0){
	elsif($tr>=7 && $tr<9 && $na>=0 && $sus>=0){
		#elsif($dr==7 && $sus==2){
		$row->[1] = 'Possible XDR';
	}

	elsif($tr==9 && $sus==0 && $na>=0){
		$row->[1] = 'Possible TDR';
	}
	else{
		$row->[1] = 'Data could not be classified';
		#print "data not sufficient flag status 'sus,tr,na,dr': $sus\t$tr\t$na\t$dr\t\n";
		print "$row->[0],$sus,$dr,$na,$tr\n"
	}
	#print "$row->[1]\n";

	$csv->say( *OUTPUT, $row );
	#print "Count DR = $dr\n";
}

