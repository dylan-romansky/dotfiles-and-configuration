#!/bin/bash

## this script assumes that you've got the symlinks
## .mainconf and .extraconf in your $HOME/.config/i3/ folder
## pointed at the main i3config file and the i3extras file
## respectively

## get the variables for this machine's configuration
source "$HOME/.config/i3/.i3vars"

## remove the old config file and copy over the main config
CONFIG="$HOME/.config/i3/config"
if [ -f "$CONFIG" ]; then
	rm "$CONFIG"
fi
cp "$HOME/.config/i3/.mainconf" "$CONFIG"

## check for extra settings and concatonate them onto our
## config if needed
if [ -f "$HOME/.config/i3/.extraconf" ]; then
	cat "$CONFIG" "$HOME/.config/i3/.extraconf" >> "/tmp/i3conf"
	mv "/tmp/i3conf" "$CONFIG"
fi

## set our terminal emulator for this machine/session
sed -i --follow-symlinks "s/set \$term*/set \$term $TERMINAL/" "$HOME/.config/i3/config"
shift

## disable lines according to our variable for this machine
for line in "${i3LINES[@]}"; do
	echo "doing line $line"
	sed -i -e "$line s/./#&/" "$CONFIG"
done
