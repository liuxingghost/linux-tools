from string import *
import sys
import os

def dts_find(name, delta):
        olddir=os.getcwd()
        newdir=""
        if name.find('/') != -1:
                newdir= os.path.dirname(name)      
                name =os.path.basename(name)
                os.chdir(newdir)
	if os.path.isfile(name):
		fp = open(name)
		for line in fp:
            #print line
			if line.find('/include/') != -1 or (line.find('#include') != -1 and line.find('dtsi') !=-1):
				if line.startswith('/include/') or line.startswith('#include'):
					dts_file = line.split('"')[1]
					print delta + dts_file
					delta_char = delta + '\t'
					dts_find(dts_file, delta_char)
		fp.close()
	else:
		print name+" is not exist"

        if newdir != "":
                os.chdir(olddir)        

dts_find(sys.argv[1], '')

