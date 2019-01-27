#!/usr/bin/env bash
##author: zhoujie<13456774460@139.com>
##这个脚本的作用是：生成咪咕彩漫的xxxxxxxx|xxxxxxxx格式的通信录文件，并排除咪咕号码

##调试开关
# -u  Treat unset variables as an error when substituting.
# -x  Print commands and their arguments as they are executed.
#set -eux

readonly randSortedFile=sorted_rand.txt
readonly miguSortedFile=sorted_migu.txt


##生成咪咕通信录
node onlyCreateMigusssPhones.js

##生成随机号码
node onlyCreateRandomPhones.js

#生成最终结果
##排除已在前面月份中发过的号码
function comm_months_and_migu_phones () {

	local noMiguFile=no_migu_phone.txt

	echo "生成排除咪咕的通信录:${noMiguFile}......."

	local monthsAndMiguFile=monthsAndMiguFile.txt

	##清空temp.txt
	true > temp.txt

	##把前面月份中的号码写入temp.txt
	find . -maxdepth 1 -name "no_migu_phone-*" -exec cat {} >> temp.txt \;

	##把咪咕中的号码写入temp.txt
	if [[ -f "sorted_all.txt" ]]; then
		cat "sorted_all.txt" >> temp.txt
	else
		echo"sorted_all.txt file not exist"
		exit 0;
	fi
	

	##排序并排除重复的号码
	sort -u temp.txt >$monthsAndMiguFile
	rm temp.txt

	#生成最终结果
	comm -23 ${randSortedFile} ${monthsAndMiguFile} >${noMiguFile}

	##清除生成的中间文件
	rm $monthsAndMiguFile
}

comm_months_and_migu_phones

rm ${randSortedFile}

echo Done!!!
 