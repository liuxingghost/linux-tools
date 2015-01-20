#!/bin/sh

out_path=../../../LINUX/android/out/target/product/
DEL_DIR_1="Common"
DEL_DIR_2="generic"
change_path=0
for i in `ls $out_path` 
do
    if [ $i != $DEL_DIR_1 -a $i != $DEL_DIR_2  ] ; then
        tmp=$out_path$i
	out_path=$tmp
	change_path=1
    fi
done
if [ "$change_path" -eq 0 ] ;then
	export bev_path=`find ${out_path}/* -type d -prune`
else
	export bev_path=$out_path
fi

