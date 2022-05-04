#!/bin/bash

#a simple utility script for i3blocks. It gets the
#current temperature of the cpu and returns colourized
#output in a format that i3blocks can use

#TODO: create a gradient

TEMP=$(acpi -t | awk '{ printf $4 }')
echo "${TEMP}C"
echo
TEMP=$(printf "%.0f\n" $TEMP)
if [ $TEMP -ge 50 ]; then
	echo "#FFFF00"
elif [ $TEMP -ge 80 ]; then
	echo "#FF0000"
else
	echo "#00FF00"
fi
