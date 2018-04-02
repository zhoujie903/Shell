#!/usr/bin/env bash
##author: zhoujie<13456774460@139.com>
##用来删除torrent文件

cd /var
echo "当前文件夹："$PWD
echo "删除当前文件夹下的所有torrent文件..."

sudo find . -name "*.torrent" -exec rm {} \; 2>/dev/null

echo "完成"

