#!/bin/sh

#another helper script for custom terminal prompts. This one
#monitors how much ram is being used and offers a
#corresponding colour for you to colour a portion of your
#prompt with

COLOUR=(46 82 118 154 190 226 220 214 208 202 196)
TOTAL="$(awk '/MemTotal/{ printf $2 }' /proc/meminfo)"
USED="$(($TOTAL - $(awk '/MemAvailable/{ printf $2 }' /proc/meminfo)))"
PERC=$(($USED * 100 / $TOTAL))
INDEX="$((($PERC - 24) / 6))"
if [ $INDEX -lt 0 ]; then
	INDEX=0
elif [ $INDEX -gt 10 ]; then
	INDEX=10
fi
printf "\e[38;5;${COLOUR[$INDEX]}m"
