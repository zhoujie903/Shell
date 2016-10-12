case $1 in
	*/* ) printf "%s\n" "${1%/*}"
		;;
	*) [ -e "$1" ] && printf "%s\n" "$PWD" || echo '.'
esac