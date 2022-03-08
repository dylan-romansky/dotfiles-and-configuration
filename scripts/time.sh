#!/bin/sh
#      0  1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21  22 23

#another piece of the custom prompt assistance scripts. This
#one takes the current time and uses it to offer a colour that
#might loosely approximate the colour of the sky at that time
#of day so you can colour a portion of your terminal prompt

HOURS=(57 21 27 26 25 32 39 38 45 44 87 123 123 116 153 159 195 188 187 181 183 176 169 92)
printf "\e[38;5;${HOURS[$(date '+%H')]}m"
