#!/bin/awk -f

BEGIN{
	title=" "
}
{
	if(title !=$1 ){
		title = $1;
		print $1;
		print $2;
	}else
		print $2;
	
}
