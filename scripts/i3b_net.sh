#!/bin/bash

#For my i3blocks configuration, allows me a simple way to
#monitor my network connection and strength complete with
#some colour formatting using pango markup

function STR () {
	STR=$(awk 'NR==3 {print $3 }' /proc/net/wireless)
	if [ $STR -le 25 ]; then
		COL="#FF0000"
	elif [ $STR -le 50 ]; then
		COL="#FFFF00"
	else
		COL="#00FF00"
	fi
	echo "<span color=\"$COL\">${STR}0%</span>"
}

function SSID () {
	SSID=$(iwgetid -r)
	if [ -z "$SSID" ]; then
		echo -n -e "<span color=\"#FF0000\" font=\"Font Awesome 6 Free\">\xef\x9e\x94</span>"
	else
		echo -n -e "<span color=\"#91E78B\"><span font=\"Font Awesome 6 Free\">\xef\x87\xab</span> $SSID:</span>"
	fi
}

echo "$(SSID) $(STR 2>/dev/null)"
