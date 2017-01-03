#!/usr/local/bin/bash
##author: zhoujie<13456774460@139.com>
##Localizable.strings文件中字符串替换掉代码文件中字符串为NSLocalizedString(@“key”, nil)


##调试开关
#set -x

#必须先声明
#declare -A dic
declare -a ss
declare -a kk 

#提取values
##############################################################
sed -n -e 's/\(.*=\s*\)\(".*"\);/\2/p' $1 >values.txt
printf "\n" >>values.txt
count_values=$(cat ./values.txt|wc -l)
printf "values:%s\n" ${count_values}
##############################################################


#提取keys
##############################################################
sed -n -e 's/\(".*"\)\(\s*=\s*.*;\)/\1/p'  $1 >keys.txt
printf "\n" >>keys.txt
count_keys=$(cat ./keys.txt|wc -l)
printf "keys:%s\n" ${count_keys}
##############################################################


if [[ $count_values != $count_keys ]]; then
	echo "键与值数量不相等"
	exit -1
fi


##############################################################
n=1  
while ((n<=${count_values}))  
do  
    ss[$n]=$(cat values.txt | sed -n "${n}p" ) 
    #printf "|%s|\n" "${ss[$n]}"
    ((n+=1))      
done
##############################################################


##############################################################
n=1  
while ((n<=${count_keys}))  
do  
    kk[$n]=$(cat keys.txt | sed -n "${n}p" ) 
    #printf "|%s|\n" "${kk[$n]}"
    ((n+=1))      
done
##############################################################


#建立字典：
##############################################################
# for (( i = 0; i < ${#ss[@]}; i++ )); do
# 	#printf "$i:|%s|%s\n" "${kk[$i]}" "${ss[$i]}"
# 	#dic["${kk[$i]}"]=${ss[${i}]}
# done
##############################################################


#字符串替换
##############################################################
for (( i = 0; i < ${#ss[@]}; i++ )); do
	#printf "正在替换:|%s|\n" "${kk[$i]}"
	if [[ "${kk[$i]}" == '""' || -z "${kk[$i]}" ]]; then
		echo 1 >/dev/null	
	else
		printf "正在替换:|%s| --> |%s|\n" "${ss[${i}]}" "${kk[${i}]}"
		sed -i -e "s/@${ss[${i}]}/NSLocalizedString(@${kk[${i}]}, nil)/" *.m
	fi
done
##############################################################

