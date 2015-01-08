#!/bin/sh

#  1-执行命令行后，抛弃所有的输出，并后台执行(如打开代理)
python proxy.py > /dev/null 2>&1 &
#  > /dev/null                     将输出重定向到/dev/null ---> 既丢掉所有的输出
#  2>&1                            将错误输出重定向到标准输出  
#   &                              后台执行前面的命令

#  2 --- 在目录下所有文件中查找关键字---
find 11 22 33 -name "*.mk" -exec grep -nH -e -i "xxx" {} +
#  11 22 33                       为想要查找的目录  
#  *.mk                           为要找文件的类型 可自由修改
#  xxx                            为要找的关键字
grep "xxx" 11 22 33 -nH -i --include="*.mk" --include="*.org" -r 
# xxx                             为要找的关键字
# 11 22 33                        为要找的目录
# *.mk *.org                      为要找的文件类型 可自由修改添加

#
