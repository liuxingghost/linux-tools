#!/bin/awk -f
BEGIN{
	str=""
	b[1]=""
	a[1]=""
	i=1
	flag=1
	# while(getline  < ARGV[1] ){
	# 	if(/Lollipop-CS/){
	# 		print $0 >> "tt"
	# 	}
		
	# 	if(/^commit/){
	# 		str=$0
	# 		print $0 >> "tt"
	# 	}
		
	# 	if(/FID/){
	# 		print $str >> "tt"
	# 		str="xxx"
	# 	}
	# }
#	system("mv tt "ARGV[1]"");
}
{
	if(/Lollipop-CS/){
		b[i++]=$0
	}
		
	if(/^commit/){
		a[1]=$0
	}
	if(/FID/){
		b[i++]=a[1]
		b[i++]=$0
		
	}
	
}
END{
	for(j=1;j<i;j++)print b[j]
}
