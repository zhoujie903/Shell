#!/usr/bin/env bash
#这个脚本的作用是：把咪咕网站上的通信录里的json格式手机号提取为和彩漫的xxxxxxxx|xxxxxxxx格式的通信录文件

progname=${0##*/} ## Get the name of the script without its path
folder=${0%/*}
echo "cd folder:" $folder

cd $folder

#grep:
#-o, --only-matching
#	Prints only the matching part of the lines.

#-r, --recursive
#	Recursively search subdirectories listed 

#grep -r -o '[0-9]\{11\}|[0-9]\{11\}' * >all.txt

#awk
#[ -F fs ]
#The -F fs option defines the input field separator to be the regular expression fs

#sed
#&
#	&:保存查找串以便在替换串中引用:s/my/**&**/  符号&代表查找串。my将被替换为**my**

if [[ -f temp.txt ]]; then
	rm temp.txt
fi

#处理json格式
grep -r -o '"\d\{11\}"' * | grep -o '\d\{11\}' | sed 's/\d\{11\}/&|&/' > temp.txt

grep -r -o '\d\{11\}|[0-9]\{11\}' * | awk -F ':' '{print $2}' >all.txt

if [[ -f temp.txt ]]; then
	rm temp.txt
fi


