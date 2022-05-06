#!/bin/bash

#TODO: create gradient

TOTAL=0
USED=1
FREE=2
RAM=($(free | awk 'FNR==2 { print $2 " " $3 " " $4 }'))
OUT="$(bc <<< "${RAM[$USED]} / 1048576")GB/$(bc <<< "${RAM[$TOTAL]} / 1048576")GB"
echo -e "<span font=\"Font Awesome 6 Free\">\xef\x83\xa8</span>: $OUT"
echo -e "$OUT"
FREE=$(bc <<< "${RAM[$FREE]} / 1048576")
if [ $FREE -le 2 ]; then
	echo "#FF0000"
elif [ $FREE -le 7 ]; then
	echo "#FFFF00"
else
	echo "#00FF00"
fi
