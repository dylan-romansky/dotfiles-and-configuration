#!/bin/bash

# a wrapper script so this data sticks around when invoked from
# an i3 keybinding. done this way because the recommended
# 'bash -c' workaround didn't let me comfortably browse the
# output whereas using a wrapper script does

sudo dmidecode | less
