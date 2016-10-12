#!/bin/bash
##author: zhoujie<13456774460@139.com>
##用来把友盟中的错误地址转换为符号

##调试开关
#set -x

progname=${0##*/} ## Get the name of the script without its path
folder=${0%/*}
#cd $folder && echo "cd folder:" $folder

if [[ ${#} < 2 ]]; then
	echo "USAGE: $progname errorPath dSYMPath"
fi




##变量定义
error_file=${1:-errorInfo.txt}
dSYMPath=${2:-"/Users/zhoujie/Downloads/CMRead.app.dSYM"}
result_file=${error_file}_parsed.txt


##提取cpu架构
arch=$( sed -n '/CPU Type:/p'  ${error_file} | sed -n 's/CPU Type: //p' )
echo "CPU Type: " $arch

##提取Binary Image
binaryImage=$( grep -o "Binary Image: [0-9a-zA-Z]*"  ${error_file} )
binaryImage=${binaryImage##"Binary Image: "}
echo "Binary Image: " $binaryImage


##提取错误地址列表
addresses=$(grep $binaryImage ${error_file} | grep -o "0x[0-9a-f]*")

##清空文件
> $result_file 

##错误地址转换为符号
for i in $addresses; do
	{
		printf "addresses: %s\n" $i  
		dwarfdump --arch=$arch --lookup $i "$dSYMPath" | grep "AT_name\|Line table file" 
		printf "\n\n" 		
	} >> $result_file	
done


##附上原错误信息
printf "\n\n" >> $result_file 
cat $error_file >> $result_file 


##打开文件
open $result_file
echo "解析结果：$PWD/$result_file"
