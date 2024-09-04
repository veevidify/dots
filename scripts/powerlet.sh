#!/bin/bash

options="  Suspend
  Poweroff
  Reboot
  Lock
  Logout
  Cancel"
theme=$HOME/.config/custom/material-warm.rasi
selection=$(echo -e "${options}" | rofi -i \
	-font "Font Awesome 16" \
  -width 320 \
	-location 2 \
  -bw 3 \
  -yoffset 200 \
	-hide-scrollbar \
	-show-icons \
	-drun-icon-theme hicolor \
  -theme ${theme} \
  -no-fixed-num-lines \
  -dmenu -p)

echo "This is your selection: $selection"

case "${selection}" in
    "  Poweroff")
        shutdown now;;
    "  Reboot")
        shutdown -r now;;
    "  Lock")
        lock;;
    "  Suspend")
        ssuspend;;
    "  Logout")
        i3-msg exit;;
    "  Cancel")
        exit;;
esac
