#!/usr/bin/env python3

#a simple, short little script for my i3blocks setup

#TODO: create a gradient

import psutil

PER=psutil.cpu_percent(interval=2)
SPAN=""
UNSPAN=""
if PER >= 50:
    SPAN="<span color=\"#FFFF00\">"
    UNSPAN="</span>"
elif PER >= 80:
    SPAN="<span color=\"#FF0000\">"
    UNSPAN="</span>"
OUT='<span color="#f5af19" font="Font Awesome 6 Free">\uf2db</span>:' + SPAN + str(str(PER) + "%").center(6) + UNSPAN
print(OUT)
