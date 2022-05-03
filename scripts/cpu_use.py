#!/usr/bin/env python3

#a simple, short little script for my i3blocks setup

import psutil
print("CPU: " + str(psutil.cpu_percent(interval=0.5)) + "%")
