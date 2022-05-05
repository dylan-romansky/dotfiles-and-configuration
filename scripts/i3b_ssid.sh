#!/bin/bash

SSID=$(iwgetid -r)
if [ -z "$SSID" ]; then
	echo "Disconnected"
	echo "Down"
	echo "#FF0000"
else
	echo "$SSID"
	echo "Conn"
fi
