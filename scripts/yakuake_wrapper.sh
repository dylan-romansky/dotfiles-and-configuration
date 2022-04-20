#!/bin/bash

# This script allows me to use the same keybinding in i3 to
# either start an instance of yakuake or kill the current
# instance

PID="$(pidof yakuake)"
if [ -z "$PID" ]; then
	yakuake
else
	kill $PID
fi
