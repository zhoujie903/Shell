#!/usr/bin/env bash

#查找imageNamed:@".*"，排序，去重

#set:
#-x  Print commands and their arguments as they are executed.
#set -x

progname=${0##*/} ## Get the name of the script without its path
folder=${0%/*}
cd $folder && echo "cd folder:" $folder

rm imageNamed.txt

#grep:
#-o, --only-matching
#	Prints only the matching part of the lines.

#-r, --recursive
#	Recursively search subdirectories listed 

#-h, --no-filename
#             Never print filename headers (i.e. filenames) with output lines.

#sort
#-u, --unique
#              with  -c, check for strict ordering; without -c, output only the
#              first of an equal run

optExclude="--exclude=$progname --exclude=*.h --exclude=*.xcassets --exclude=*.lproj --exclude=*.html --exclude=*.plist"

time grep -r -o --no-filename $optExclude 'imageNamed:@".*"]' * | grep -o -E '".+"' | sort -u >imageNamed.txt

