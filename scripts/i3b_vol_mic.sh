#!/bin/bash

while [ -z $LEV ]; do
	if [ -z $1 ]; then
		LEV=$(pactl get-sink-volume @DEFAULT_SINK@ | awk 'FNR==1{ print " " $5 }')
	else
		LEV=$(pactl get-source-volume @DEFAULT_SOURCE@ | awk 'FNR==1{ print " " $5 }')
	fi
done
if [ -z $1 ]; then
	if [[ "$(pactl get-sink-mute @DEFAULT_SINK@)" == *"yes"* ]]; then
		STAT="\xef\x9a\xa9:"
	else
		DEC=$(echo $LEV | cut -d% -f1)
		if [ $DEC -le 20 ]; then
			STAT="\xef\x80\xa6 :"
		elif [ $DEC -le 60 ]; then
			STAT="\xef\x80\xa7 :"
		else
			STAT="\xef\x80\xa8 :"
		fi
	fi
else
	STAT="\xef\x84\xb0:"
fi
echo -e "<span font=\"Font Awesome 6 Free\">$STAT</span>$LEV"
echo -e "<span font=\"Font Awesome 6 Free\">$STAT</span>$LEV"
