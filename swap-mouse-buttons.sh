#!/bin/sh

# left-hand and swap middle-button and right-button
# with a Logitech wireless mouse.

logitechWirelessMouseID=$(xinput --list | grep -F 'Logitech' | grep -F 'Wireless' | grep -E -o 'id=[0-9]+' | grep -E -o '[0-9]+')
xinput --set-button-map $logitechWirelessMouseID 2 3 1
