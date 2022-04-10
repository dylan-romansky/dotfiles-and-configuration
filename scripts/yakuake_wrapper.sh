#!/bin/bash

killall notify-osd
PID="$(pidof yakuake)"
if [ -z "$PID" ]; then
	yakuake
else
	kill $PID
fi
