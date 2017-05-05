#!/usr/bin/env bash

#ls
#	-l
 List in long format
#	-R Recursively list subdirectories encountered
ls -l -R |grep "^d" | awk '{print $9}' | grep "imageset" | sort > imageset.txt