images=$( ls -R -l | grep "^d" | grep "\.imageset" | grep -o ":\d\d .\+\.imageset" | sed -n -e "s/:[0-9][0-9] //;s/\.imageset$//gp" )
> unusedImages.txt
for i in $images; do
	ag --case-sensitive --ignore allimages.txt --ignore unusedImages.txt --ignore-dir "Images.xcassets" "$i" './'
	if [[ $? -ne 0 ]]; then
		echo "$i" >> unusedImages.txt
	fi
done