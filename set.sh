#!/usr/bin/env bash
#test function

function testFunction
{
	echo $#
	local IFS=.
	set -- $1
	echo $#
	echo "\$@=" "$@"
	echo "\$*=" "$*"
}

testFunction 192.168.111.100