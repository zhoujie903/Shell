#!/bin/bash
##author: zhoujie<13456774460@139.com>
##查找xcdoe iOS APP项目xcassets中不再使用的图片
##这个sh依赖于ag命令：https://github.com/ggreer/the_silver_searcher

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

images=$( ls -R -l | grep "^d" | grep "\.imageset" | grep -o ":\d\d .\+\.imageset" | sed -n -e "s/:[0-9][0-9] //;s/\.imageset$//gp" )

##清空文件
unusedImages=unusedImages.txt
> $unusedImages

#ag
#A code-searching tool similar to ack, but faster. http://geoff.greer.fm/ag/
#https://github.com/ggreer/the_silver_searcher

#--case-sensitive     Match case sensitively
#---ignore PATTERN     Ignore files/directories matching PATTERN
#                          (literal file/directory names also allowed)
#--ignore-dir NAME    Alias for --ignore for compatibility with ack.

time for i in $images; do
	ag -Q --case-sensitive --ignore $unusedImages --ignore-dir "*.xcassets" "$i" './'
	if [[ $? -ne 0 ]]; then
		echo "$i" >> $unusedImages
	fi
done
