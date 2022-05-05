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
		echo -n "<span color=\"#FF0000\">Disconnected</span>"
	else
		echo -n "<span color=\"#91E78B\">$SSID:</span>"
	fi
}

echo "$(SSID) $(STR 2>/dev/null)"
