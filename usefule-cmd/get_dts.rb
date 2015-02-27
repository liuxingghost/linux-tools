#!/usr/bin/ruby -w
# coding: utf-8

$dts_file_name=""
$show_all_dtsi=0 # -p
$get_all_dtsi=0  # -g

class Xddts
  def set_dts_file(name)
    @dts_file=name
    #测试文件是否存在
    return File::file?(@dts_file)
  end
  def get_dts_base
    return @dts_file
  end
  def show_all_dtsi(name,num) # 打印dts文件树
    @old_dir=Dir::getwd
    @new_dir=""
    if(name =~ /\//)#判定是否需要切换路径
      @new_dir=File::dirname(name) #获取新路径
      name=File::basename(name)    #获取文件名
      Dir::chdir(@new_dir)         #切换路径到新路径下
    end
    
    fp=File.open(name) if File.exist?(name)#判定文件是否存在并打开文件
    fp.each do |line|                     #按行匹配 
      if((line=~/^#include/ or line=~/^\/include\//) and (line=~/dtsi/))#查找include行
        puts "\t"*num+line.split("\"")[1] #打印前导空格和文件名
        @dtsi_file=line.split("\"")[1]    #获取文件名 既“”中间部分
       show_all_dtsi(@dtsi_file,num+1)    #递归调用
      end
    end
    if(@new_dir != "")                   #切换路径后需要回退
      Dir::chdir(@old_dir)
    end
  end
  def get_all_dtsi(name) # 展开所有的dtsi文件生成完整的dts
#    puts Dir::pwd
    @dts_file_all=name+"-x-all"
    @dts_base=name
   	`cpp -Wp,-MD,x.pre.tmp -nostdinc -I. -Iinclude  -undef -D__DTS__ -x assembler-with-cpp -o xx.dts.tmp #@dts_base`
	`dtc -I dts -O dts -o #@dts_file_all xx.dts.tmp`
	`rm -rf xx.dts.tmp`
  end
  def print_help()
    puts "use as :ruby get_dtsi.rb -p -g xxx.dts"
  end
end
xddts=Xddts.new()
ARGV.each do  |line|###解析命令行参数
  if(line =~/-p/)   #打印dts文件树
    $show_all_dtsi=1
  elsif (line =~/-g/)
    $get_all_dtsi=1 #展开所有的dtsi文件，生成一个文件
  else
    if(line =~/^-/) #只识别两个选项-p/-g
      xddts.print_help
      exit()
    else
      $dts_file_name=line
    end
  end
end
if !xddts.set_dts_file($dts_file_name)
  puts "#$dts_file_name is not exist!!!"
  xddts.print_help
  exit
end
#是否展开所有包含文件，生成完整的dts文件
if($get_all_dtsi ==1)
  xddts.get_all_dtsi(xddts.get_dts_base)
end
#是否显示总dts文件包含文件树
if($show_all_dtsi == 1)
  xddts.show_all_dtsi(xddts.get_dts_base,0)
end

  



