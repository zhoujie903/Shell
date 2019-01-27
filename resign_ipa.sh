#!/usr/bin/env bash
##author: zhoujie<zhoujie_903@163.com>
##这个脚本的作用是：对未加密的app重签名，需要有效的mobileprovision文件

##调试开关
# -u  Treat unset variables as an error when substituting.
# -x  Print commands and their arguments as they are executed.
#set -eux

# 定义要重签名的app文件路径、和有效的mobileprovision文件路径
APP_FILE=~/Desktop/WeChat/Payload/WeChat.app
PP_PATH=~/Downloads/Code_Signing_Example_ProvisProfile_92618.mobileprovision

# 得到application-identifier
EXTRACTED_ENT="/tmp/extracted_ent"
security cms -D -i "$PP_PATH" > "$EXTRACTED_ENT"
APP_IDENTIFIER=$(/usr/bin/xpath "$EXTRACTED_ENT" '//*[text() = "application-identifier"]/following-sibling::string[1]/text()' 2>/dev/null |  cut -d. -f 2-80 ) 
echo "app id is : $APP_IDENTIFIER"

# 复制mobileprovision文件为app内的embedded.mobileprovision
cp "$PP_PATH" "$APP_FILE/embedded.mobileprovision"

# 删除PlugIns文件夹、和
rm -rf "$APP_FILE/PlugIns"
rm -rf "$APP_FILE/Watch"

# 替换Info.plist内的CFBundleIdentifier、CFBundleDisplayName
plutil -replace CFBundleDisplayName -string "Woot" "$APP_FILE/Info.plist"
plutil -replace CFBundleIdentifier -string ${APP_IDENTIFIER} "$APP_FILE/Info.plist"

# 生成签名app用的entitlements.xml
rm /tmp/ent.xml && codesign -d --entitlements :/tmp/ent.xml "$APP_FILE/WeChat"
rm /tmp/scratch && security cms -D -i "$PP_PATH" > /tmp/scratch

# 这名命令有点缺陷：生成的<true />多了一个空格，正确的是<true/>
xpath /tmp/scratch '//*[text() = "Entitlements"]/following-sibling::dict' 2>/dev/null | grep -v -e '^$' | sed -e "s| /|/|g" | pbcopy 
# [不要用剪切板，否则会把上面命令得到剪切板中的内容给覆盖了。把剪切板上的内容粘贴到/tmp/ent.xml中]
open /tmp/ent.xml 

# 等待 /tmp/ent.xml编织完成 
echo "编辑完ent.xml保存后，按回车继续重签名"
read wait_ent_done

# 重签名Frameworks、 和app
codesign --deep -f -s "iPhone Developer: zhoujie_903@163.com (TCDLVFEQHJ)" "$APP_FILE/Frameworks/"*
codesign --deep -f -s "iPhone Developer: zhoujie_903@163.com (TCDLVFEQHJ)" --entitlements /tmp/ent.xml "$APP_FILE"

# 安装到真机
mobdevim -i "$APP_FILE"