pre=:
post=:
printf "$pre%s$post\n" "$@"





#Special *@#0$?_!- Parameters

#$* and $@, expand to the value of all the positional parameters combined
echo "\$@:" $@
echo "\$*:" $*
echo "\$0:" $0
echo "\$1:" $1
echo "\$_:" $_ #好像不起作用
echo "\$-:" $-

# n=1
# while [ $n -le 10 ]
# do 
# 	echo "$n"
# 	n=$(( $n + 1 ))
# done


# n=1
# until [ $n -gt 10 ]
# do 
# 	echo "$n"
# 	n=$(( $n + 1 ))
# done

# for var in Canada USA Mexico 
# do
# 	printf "%s\n" "$var"
# done

# while : 
# do
# 	read x
# 	[ -z "$x" ] && break
# done

# for n in {1..9}
# do
# 	x=$RANDOM
# 	[ $x -le 10000 ] && continue
# 	echo "n=$n x=$x"
# done