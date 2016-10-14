
set -x
./imageNamed.sh

./storyboard.sh

cat imageNamed.txt storyboard.txt | sort -u >all.txt
