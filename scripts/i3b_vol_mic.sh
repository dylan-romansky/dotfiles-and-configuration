#!/bin/bash

#simple script for i3blocks that gets the volume or mic
#levels and prints them with a unicode icon

while [ -z $SLEV ] && [ -z $MLEV ]; do
	SLEV=$(pactl get-sink-volume @DEFAULT_SINK@ | awk 'FNR==1{ print " " $5 }')
	MLEV=$(pactl get-source-volume @DEFAULT_SOURCE@ | awk 'FNR==1{ print " " $5 }')
done
if [[ "$(pactl get-sink-mute @DEFAULT_SINK@)" == *"yes"* ]]; then
	SSTAT="\xef\x9a\xa9:"
else
	DEC=$(echo $SLEV | cut -d% -f1)
	if [ $DEC -le 20 ]; then
		SSTAT="\xef\x80\xa6"
	elif [ $DEC -le 60 ]; then
		SSTAT="\xef\x80\xa7"
	else
		SSTAT="\xef\x80\xa8"
	fi
fi
MSTAT="\xef\x84\xb0"
echo -e "<span font=\"Font Awesome 6 Free\">$SSTAT</span>$SLEV <span font=\"Font Awesome 6 Free\">$MSTAT</span>$MLEV"
