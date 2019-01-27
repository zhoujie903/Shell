#!/usr/bin/env bash
##author: zhoujie<13456774460@139.com>
##这个脚本的作用是：生成咪咕彩漫的xxxxxxxx|xxxxxxxx格式的通信录文件，并排除咪咕号码

##调试开关
#set -eux

readonly randSortedFile=sorted_rand.txt
readonly miguSortedFile=sorted_migu.txt

function rand() {  
    local min=$1  
    local max=$(($2-min+1))  
    local num
    num=$(head -n 11 < /dev/urandom | cksum | awk -F ' ' '{print $1}') 
    echo $((num%max+min)) 
}


function create_migu_phones () {
	echo "生成咪咕通信录:${miguSortedFile}......."

	##找出所有子公司目录下的sorted_all.txt文件	
	local company
	company=$(find . -mindepth 1 -name sorted_all.txt)

	##读取所有sorted_all.txt文件内容，并排序和剔除重复号码，最后写入${miguSortedFile}文件
	cat $company | sort -u > ${miguSortedFile} 
} 


function create_random_phones () {
	echo "生成随机号码:${randSortedFile}......"

	local randFile=rand.txt

	true > ${randFile}

	##生成randFile(rand.txt)文件
	for (( i = 0; i < 3000; i = $((i + 1)) )); do
		rnd=$(rand 13400000000 13999999999)
		printf "%d|%d\n" "$rnd" "$rnd" >>${randFile}
	done

	#排序随机号码
	sort -u ${randFile} > ${randSortedFile}

	#删除随机号码文件
	rm ${randFile}
} 


create_migu_phones

create_random_phones

#生成最终结果
##排除已在前面月份中发过的号码
function comm_months_and_migu_phones () {

	local noMiguFile=no_migu_phone.txt

	echo "生成排除咪咕的通信录:${noMiguFile}......."

	local months_and_migu_phones=months_and_migu_phones.txt

	##清空temp.txt
	true >temp.txt

	##把前面月份中的号码写入temp.txt
	find . -maxdepth 1 -name "no_migu_phone-*" -exec cat {} >>temp.txt \;

	##把咪咕中的号码写入temp.txt
	cat ${miguSortedFile} >>temp.txt

	##排序并排除重复的号码
	sort -u temp.txt >$months_and_migu_phones
	rm temp.txt

	#生成最终结果
	comm -23 ${randSortedFile} ${months_and_migu_phones} >${noMiguFile}

	##清除生成的中间文件
	rm $months_and_migu_phones 

	#open ${noMiguFile} 
}

comm_months_and_migu_phones

rm ${randSortedFile}

echo Done!!!
 