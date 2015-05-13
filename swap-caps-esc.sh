#!/bin/sh

### Swap esc and caps.

# A list of available options:
/usr/share/X11/xkb/rules/evdev.lst

setxkbmap -option caps:swapescape
