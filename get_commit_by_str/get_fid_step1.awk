#!/bin/awk -f
BEGIN{
	line=" "
}

{
	if(/^=/){
		print $0
	}
	if(/^commit/){
		a=$0
		getline;
		getline;
		getline;
		getline;
		getline;
		getline;		
 		getline line;
		  if(match($line,"FID")){
		  	print a
		   	print $line
		  }
	}
}
