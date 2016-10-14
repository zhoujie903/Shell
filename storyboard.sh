#!/bin/bash


#grep  -o '<image\s*name=".*"\s' $1 

grep  -r -o --include=*.storyboard '<image\s\+name=".\+"\sw' * | grep -o '".\+"' | sort -u >storyboard.txt


