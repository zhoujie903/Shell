#!/usr/bin/env bash
##author: zhoujie<13456774460@139.com>
##Localizable.strings文件中字符串替换掉代码文件中字符串为NSLocalizedString(@“key”, nil)


##调试开关
#set -eux

#必须先声明
#declare -A dic
declare -a ss
declare -a kk


echo "正在建立keys和values..."
##建立keys和values
##tip:Placing an assignment in front of a command causes it to be local to that command and does not change its value elsewhere in the script.
##############################################################
while IFS="=" read key value
do
    key=$( printf "%s" "${key}" | sed -n -E 's/(\s*)(".*")(\s*)/\2/p' );
    value=$( printf "%s" "${value}" | sed -n -E 's/(\s*)(".*")(;)/\2/p' )
    if [[ "${key}" == '""' || -z "${key}" || "${value}" == '""' || -z "${value}" ]]; then
        :  #do nothing    
    else
        ss[${#ss[@]}]=${value};
        kk[${#kk[@]}]=${key};
        #printf "key:|%s| -- value:|%s|\n" "$key" "$value"
    fi
    key=""
    value=""
done < "$1"
#echo IFS $IFS
##############################################################


if [[ ${#ss[@]} != ${#kk[@]} ]]; then
    echo "键与值数量不相等"
    exit -1
fi


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

echo done!!!
