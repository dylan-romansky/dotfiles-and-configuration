#!/bin/bash

#for custom terminal prompts, monitors the temperature of your
#cpu and offers a corresponding colour to colour a portion of
#your prompt with

COLOUR=(46 82 118 154 190 226 220 214 208 202 196)
TEMP=$(bc <<< "(($(acpi -t | awk '{ printf $4 }') - 40) / 5)")
if [ $TEMP -lt 0 ]; then
	TEMP=0
elif [ $TEMP -gt 10 ]; then
	TEMP=10
fi
printf "\e[38;5;${COLOUR[$TEMP]}m"
