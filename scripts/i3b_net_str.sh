#!/bin/bash

STR=$(awk 'NR==3 {print $3 }' /proc/net/wireless)
echo "$STR%"
echo "$STR%"
if [ $STR -le 25 ]; then
	echo "#FF0000"
elif [ $STR -le 50 ]; then
	echo "#FFFF00"
else
	echo "#00FF00"
fi
