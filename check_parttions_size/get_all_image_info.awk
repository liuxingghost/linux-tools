#!/bin/awk -f

BEGIN{
	FS= "\"";
}

/\.img/{
	for(i=1;i<=NF;i++){
		if(match($i,"\.img"))
			print $i"|"$4
	}
}
/\.mbn/{
	for(i=1;i<=NF;i++){
		if(match($i,"\.mbn"))
			print $i"|"$4
	}
}
/\.bin/{
	for(i=1;i<=NF;i++){
		if(match($i,"\.bin"))
			print $i"|"$4
	}
}
