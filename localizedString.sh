#!/usr/local/bin/bash

##调试开关
#set -x

#必须先声明
declare -A dic
declare -a ss
declare -a kk 

#grep -o -E '=\s*".+"' $1

strings=$( sed -n -e 's/\(.*=\s*\)\(".*"\);/\2/p'  $1)
for item in $strings; do
	#echo ${item}
	ss[${#ss[@]}]=${item}
done

keys=$( sed -n -e 's/\(".*"\)\(\s*=\s*.*;\)/\1/p'  $1)
for item in $keys; do
	#echo ${item}
	kk[${#kk[@]}]=${item}
done

for (( i = 0; i < ${#ss[@]}; i++ )); do
	dic[${kk[${i}]}]=${ss[${i}]}
	#echo kk ${kk[${i}]}
	#echo ss ${ss[${i}]}  
done

#echo ${#ss[@]}
#echo ${#kk[@]}
#echo ${dic[*]}

for (( i = 0; i < ${#ss[@]}; i++ )); do
	#echo ${ss[${i}]} 
	sed -i -e "s/${ss[${i}]}/NSLocalizedString(@${kk[${i}]}, nil)/" "/Users/zhoujie/Documents/CMRead-iPhone/CMRead-iPhone/Personal/CMBindPhoneNumberViewController.m" 
done

