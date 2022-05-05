#!/usr/bin/env python3

#a simple, short little script for my i3blocks setup

#TODO: create a gradient

import psutil
PER=psutil.cpu_percent(interval=1)
OUT="CPU: " + str(PER) + "%"
print(OUT)
print(OUT)
if PER >= 50:
    print("#FFFF00")
elif PER >= 80:
    print("#FF0000")
