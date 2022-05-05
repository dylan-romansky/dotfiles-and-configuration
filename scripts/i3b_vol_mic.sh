#!/bin/bash

if [ -z $1 ]; then
	if [[ "$(pactl get-sink-mute @DEFAULT_SINK@)" == *"yes"* ]]; then
		STAT="M:"
	else
		STAT="V:"
	fi
else
	STAT="Mic:"
fi
while [ -z $LEV ]; do
	if [ -z $1 ]; then
		LEV=$(pactl get-sink-volume @DEFAULT_SINK@ | awk 'FNR==1{ print " " $5 }')
	else
		LEV=$(pactl get-source-volume @DEFAULT_SOURCE@ | awk 'FNR==1{ print " " $5 }')
	fi
done
echo $STAT $LEV
echo $STAT $LEV
