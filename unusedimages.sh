#!/usr/bin/env bash
##author: zhoujie<13456774460@139.com>
##查找xcdoe iOS APP项目xcassets中不再使用的图片
##这个sh依赖于ag命令：https://github.com/ggreer/the_silver_searcher
##安装ag命令：brew install the_silver_searcher

##解决思路：
## 1. 列举出Assets.xcassets目录下所有的*.imageset
## 2. 对上一步找出的每一个*.imageset[图片],都在所有工程文件中查找这个图片名字的字符串
## 3. 如果所有工程文件中都不包含图片名字的字符串，则表示这个图片没有被使用
## 4. 对拼接图片名字，没有处于，只给出警告


#得到图片名字列表 方法一
#################################################################################################
#ls
#-R      Recursively list subdirectories encountered
#-l      List in long format.

#ls -R -l | grep "^d"
#过滤出目录文件

#grep "\.imageset"
#在目录文件中过滤出.imageset目录
#结果：drwxr-xr-x@ 6 zhoujie  staff  204 Jul 11 08:50 personal_cell_icon_ticket.imageset

#grep -o ":\d\d .\+\.imageset"
#过度截取出图片文件名
#结果：:50 personal_cell_icon_ticket.imageset

#sed -n -e "s/:[0-9][0-9] //;s/\.imageset$//gp"
#截取出图片文件名
#结果：personal_cell_icon_ticket

#images=$( ls -R -l | grep "^d" | grep "\.imageset" | grep -o -E ":\d\d .+\.imageset" | sed -n -e "s/:[0-9][0-9] //;s/\.imageset$//gp" )
#################################################################################################

#得到图片名字列表 方法二
#################################################################################################
#find .  -type d -name "*.imageset"
#结果：./CMRead-iPhone/Images.xcassets/AppTintColor/app_disabled_color.imageset

#sed -n -E 's/(.*\/)//;
#结果：app_disabled_color.imageset

#sed -n -E 's/(.*\/)//;
#结果：app_disabled_color
#-n, --quiet, --silent
#       suppress automatic printing of pattern space
#-E

## 1. 列举出Assets.xcassets目录下所有的*.imageset
images=$(find .  -type d -name "*.imageset" | sed -n -E 's/(.*\/)//; s/(\.imageset$)//p;')
#################################################################################################


##清空文件
unusedImages=unusedImages.txt
: > $unusedImages

##脚本名字
progname=${0##*/} ## Get the name of the script without its path


#ag
#A code-searching tool similar to ack, but faster. http://geoff.greer.fm/ag/
#https://github.com/ggreer/the_silver_searcher

#--case-sensitive     Match case sensitively
#---ignore PATTERN    Ignore files/directories matching PATTERN
#                          (literal file/directory names also allowed)
#--ignore-dir NAME    Alias for --ignore for compatibility with ack.

## 2. 对上一步找出的每一个*.imageset[图片],都在所有工程文件中查找这个图片名字的字符串
## 3. 如果所有工程文件中都不包含图片名字的字符串，则表示这个图片没有被使用
time for i in $images; do
	if ! ag -Q --case-sensitive --ignore $unusedImages --ignore $progname --ignore-dir "*.xcassets" "$i" './';
	then
		echo "$i" >> $unusedImages
	fi
done


##对误中代码块进行处理
## 4. 对拼接图片名字，没有处于，只给出警告
#########################################################
printf "请注意误查找:[UIImage imageNamed:[NSString stringWithFormat:\n" >> $unusedImages
time ag -o --ignore $progname 'imageNamed.+Format.+"' './' | sed -n -E 's/(.*@")(.*)(")/\2/p' | sort -u >> $unusedImages
printf "\n\n">> $unusedImages
#########################################################

##误中

##代码：battery_cell_night_%@
    # UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"battery_cell_night_%d",level]];

##代码：day_fonts_%@_click, day_fonts_%@_down, day_fonts_%@_normal
    # [UIImage imageNamed:[NSString stringWithFormat:@"day_fonts_%@_click", fontID]
    # [UIImage imageNamed:[NSString stringWithFormat:@"day_fonts_%@_normal", fontID]

##代码：night_fonts_%@_normal, night_fonts_%@_click, night_fonts_%@_down
	# [UIImage imageNamed:[NSString stringWithFormat:@"night_fonts_%@_normal", fontID]

##代码：speech_tone_%@_disable, speech_tone_%@_default
	# [UIImage imageNamed:[NSString stringWithFormat:@"speech_tone_%@_default", param]]
	# [UIImage imageNamed:[NSString stringWithFormat:@"speech_tone_%@_disable", param]]

##代码：load_ic_loading_%ld
	# [UIImage imageNamed:[NSString stringWithFormat:@"load_ic_loading_%ld",(unsigned long)i]]
