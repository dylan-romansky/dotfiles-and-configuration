#!/bin/bash

#For my i3blocks configuration, allows me a simple way to
#monitor my network connection and strength complete with
#some colour formatting using pango markup

#TODO: use `nmcli device status` to detect connections

function STR () {
	STR=$(awk 'NR==3 {print $3 }' /proc/net/wireless)
	if [ -z "$STR" ]; then
		return
	elif [ $STR -le 25 ]; then
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
		echo -n -e "<span color=\"#91E78B\" font=\"Font Awesome 6 Free\">\xef\x87\xab</span> $SSID:</span>"
	fi
}
# TODO: check if networking is available before doing the following
if [ "${BLOCK_BUTTON}" == 1 ]; then
	killall notify-osd
	notify-send $(nmcli -p device show | grep IP4.ADDRESS | awk 'FNR==1 { print $2 }')
elif [ "${BLOCK_BUTTON}" == 3 ]; then
	killall notify-osd
	notify-send $(curl -4 icanhazip.com)
fi
if [ -n "$(nmcli device status | grep ethernet | grep connected)" ]; then
	#I have to echo the result of an echo statement for i3_blocks
	#to properly print what I want it to. Hence this nested echo
	#here as well as the `else` condition storing the results of
	#echo statements in variables to echo later
	echo $(echo -n -e "<span color=\"#00FF00\" font=\"Font Awesome 6 Free\">\xef\x9b\xbf</span>")
else
	STRI=$(SSID)
	STR2=$(STR 2>/dev/null)
	if [ -n "$STR2" ]; then
		STRI="$STRI $STR2"
	fi
	echo "$STRI"
fi
