#!/usr/bin/env bash
##author: zhoujie<13456774460@139.com>
##用来删除torrent文件

cd /var
echo $PWD
sudo find . -name "*.torrent" -exec rm {} \; 2>/dev/null

