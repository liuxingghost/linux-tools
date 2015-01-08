#!/bin/awk -f
BEGIN{
	FS="[ |-]+"
	title=" "
	str=" "
}

{
	if(/^=/){
		title=$0
	
	}

	if(!/FID/ && !/^=/){
		str=$0 #""title;
	
	}
	if(/FID/) {
		print $0,str
	}
}
