#!/usr/bin/env bash

#查找imageNamed:@".*"，排序，去重

#set:
#-x  Print commands and their arguments as they are executed.
##set -eux

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

#-E, --extended-regexp
#          Interpret pattern as an extended regular expression (i.e. force
#          grep to behave as egrep).

#sort
#  -u, --unique
#          Unique keys.  Suppress all lines that have a key that is equal to
#          an already processed one.  This option, similarly to -s, implies
#          a stable sort.  If used with -c or -C, sort also checks that
#          there are no lines with duplicate keys.

optExclude="--exclude=$progname --exclude=*.h --exclude=*.xcassets --exclude=*.lproj --exclude=*.html --exclude=*.plist"

time grep -r -o --no-filename $optExclude 'imageNamed:@".*"]' * | grep -o -E '".+"' | sort -u >imageNamed.txt

