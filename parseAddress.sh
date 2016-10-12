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
arch=$( grep "CPU Type: arm[0-9]*"  ${error_file} | grep -o "arm[v]*[0-9]*" )
echo "CPU Type: " $arch

##提取UUID
uuid_in_error=$( grep "dSYM UUID: "  ${error_file} | grep -o "[0-9A-F]\{1,\}-[0-9A-F]\{1,\}-[0-9A-F]\{1,\}-[0-9A-F]\{1,\}-[0-9A-F]\{1,\}")
echo "uuid_in_error: " $uuid_in_error

uuid_in_dSYM=$(dwarfdump --arch=$arch --uuid $dSYMPath | grep -o "[0-9A-F]\{1,\}-[0-9A-F]\{1,\}-[0-9A-F]\{1,\}-[0-9A-F]\{1,\}-[0-9A-F]\{1,\}")
echo "uuid_in_dSYM:  " $uuid_in_dSYM

##比较UUID
if [[ $uuid_in_error != $uuid_in_dSYM ]]; then
	printf "uuid is not match:\n"
	printf "\tuuid_in_erro: %s\n" $uuid_in_error
	printf "\tuuid_in_dSYM: %s\n" $uuid_in_dSYM
	exit 1;
fi


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
		if [[ $? -ne 0 ]]; then
		 	atos -o "$dSYMPath"/Contents/Resources/DWARF/$binaryImage -arch $arch $i
		 fi 
		printf "\n\n" 		
	} >> $result_file	
done


##附上原错误信息
printf "\n\n" >> $result_file 
cat $error_file >> $result_file 


##打开文件
open $result_file
echo "解析结果：$PWD/$result_file"
