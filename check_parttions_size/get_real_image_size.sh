#!/bin/sh
#
# 读取parttions.xml文件中的镜像大小限制，并与镜像实际大小比较
#
IMG_PATH="../../LINUX/android/out/target/product/msm8974/"
IMG_PATH_ROOT="../../"
if [ $# -lt 1 ]; then
	echo "===>use $0 partitions.xml<==="
	exit 1
fi
#获取镜像文件的实际路径
check_img_file(){
 	if [ -f $IMG_PATH$1 ];then #检查镜像是否在android/out目录下
		check_img_size $IMG_PATH$1 $2
 	else # 镜像不在android/out目录下则在指定的镜像根目录下查找
		for line in `find $IMG_PATH_ROOT -name $1`
		do
			check_img_size $line $2
		done

 	fi
 }

# 比较配置文件中限制镜像大小与镜像文件实际大小
check_img_size (){
	get_size=`ls -l $1 | cut -d' ' -f5`
	echo "$1 $2 $get_size"  | awk '{if($2*1024>=$3){print $1" size ok"}else{printf("%s size error ***** limit %dk real %dk\n",$1,$2,int($3/1024));}}'
}

# 解析配置文件，获取配置文件中所有镜像及其对应大小 
for line in `awk -f get_all_image_info.awk $1 | sort -t "|" -k2 -nr`
do
	#解析后的数据格式为：xxx.img|512
	img=${line%%|*}        #获取镜像文件名
	size=${line##*|}       #获取镜像限制大小
	#echo $img,$size
	check_img_file $img $size;
done



