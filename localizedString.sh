#!/usr/local/bin/bash
##author: zhoujie<13456774460@139.com>
##Localizable.strings文件中字符串替换掉代码文件中字符串为NSLocalizedString(@“key”, nil)


##调试开关
#set -x

#必须先声明
#declare -A dic
declare -a ss
declare -a kk

values_file=values_by_shell.txt
keys_file=keys_by_shell.txt 

function removeTempFiles() {
    echo "--------------"
    rm $values_file
    rm $keys_file
}

#提取values
##############################################################
sed -n -e 's/\(.*=\s*\)\(".*"\);/\2/p' $1 >$values_file
printf "\n" >>$values_file
count_values=$(cat ./$values_file|wc -l)
printf "values:%s\n" ${count_values}
##############################################################


#提取keys
##############################################################
sed -n -e 's/\(".*"\)\(\s*=\s*.*;\)/\1/p'  $1 >$keys_file
printf "\n" >>$keys_file
count_keys=$(cat ./$keys_file|wc -l)
printf "keys:%s\n" ${count_keys}
##############################################################


if [[ $count_values != $count_keys ]]; then
    echo "键与值数量不相等"
    removeTempFiles;
    exit -1
fi


##############################################################
n=1  
while ((n<=${count_values}))  
do  
    ss[$n]=$(cat $values_file | sed -n "${n}p" ) 
    #printf "|%s|\n" "${ss[$n]}"
    ((n+=1))      
done
##############################################################


##############################################################
n=1  
while ((n<=${count_keys}))  
do  
    kk[$n]=$(cat $keys_file | sed -n "${n}p" ) 
    #printf "|%s|\n" "${kk[$n]}"
    ((n+=1))      
done
##############################################################


#建立字典：
##############################################################
# for (( i = 0; i < ${#ss[@]}; i++ )); do
#     #printf "$i:|%s|%s\n" "${kk[$i]}" "${ss[$i]}"
#     #dic["${kk[$i]}"]=${ss[${i}]}
# done
##############################################################


#字符串替换
##############################################################
for (( i = 0; i < ${#ss[@]}; i++ )); do
    #printf "正在替换:|%s|\n" "${kk[$i]}"
    if [[ "${kk[$i]}" == '""' || -z "${kk[$i]}" ]]; then
        :  #do nothing    
    else
        printf "正在替换:|%s| --> |%s|\n" "${ss[${i}]}" "${kk[${i}]}"
        sed -i -e "s/@${ss[${i}]}/NSLocalizedString(@${kk[${i}]}, nil)/" *.m
    fi
done
##############################################################


removeTempFiles;
