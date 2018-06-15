#!/usr/bin/env bash
##author: zhoujie<13456774460@139.com>
#这个脚本的作用是：上传ipa包到蒲公英网站


#蒲公英上的User Key
uKey=""	#像这个样子de6acdae9accf675e4ccc2e1d3e524b2
#蒲公英上的API Key 	
apiKey="" #像这个样子95ad1104ad53968fb6b190a7473e7586
#要上传的ipa文件路径
IPA_PATH="/Users/zhoujie/Documents/CMRead/build/*.ipa"

description="修改说明"

ipa=$(echo ${IPA_PATH})

##-a file:True if file exists
if [[ -a ${ipa} ]]; then
	echo "upload" ${IPA_PATH}
else
	echo "no ipa:" ${IPA_PATH}
fi

curl -F "file=@$(echo ${IPA_PATH})" -F "_api_key=${apiKey}" -F "buildUpdateDescription=${description}" https://www.pgyer.com/apiv2/app/upload

echo "Done"