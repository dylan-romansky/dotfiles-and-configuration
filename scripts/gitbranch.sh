#!/bin/sh

#a helper script for custom terminal prompts. offers info
#about the current directory in the event that you're
#currently inside of a git repo

#todo: add colour gradients for untracked files
COLOUR_GOOD='\e[1;32m'
COLOUR_UNTRACKED='\e[1;33m'
COLOUR_BAD='\e[1;31m'

STATUS=$(git status -sb 2> /dev/null)

if [ -n "$STATUS" ]; then
	NUM_STATUS=$(printf "$STATUS\n" | wc -l)
	BRANCH=$(echo "$STATUS" | sed "s/\.\.\./\n/" | sed -n "s/^## \(.*\)$/\1/p")
	UNTRACKED=$(echo "$STATUS" | grep "^?? ")

	if [ -n "$UNTRACKED" ]; then
		NUM_UNTRACKED=$(printf "$UNTRACKED\n" | wc -l)
	else
		NUM_UNTRACKED=0
	fi

	NUM_OTHER=$(( $NUM_STATUS - $NUM_UNTRACKED - 1 ))

	if [ $NUM_OTHER -gt 0 ]; then
		printf "\e[1;37m->$COLOUR_BAD$BRANCH\e[m"
	elif [ $NUM_UNTRACKED -gt 0 ]; then
		printf "\e[1;37m->$COLOUR_UNTRACKED$BRANCH\e[m"
	else
		printf "\e[1;37m->$COLOUR_GOOD$BRANCH\e[m"
	fi
fi
