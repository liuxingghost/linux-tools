#!/bin/awk -f
BEGIN{
	FS="[ |-]+"
}
{
	if(/^=/){
		print;
	}else print $NF;
	
}
