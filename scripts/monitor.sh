#!/bin/bash

hdmi_active=$(xrandr |grep ' connected' |grep 'HDMI' |awk '{print $1}')

[[ ! -z "$hdmi_active" ]] && xrandr --output eDP-1-1 --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI-1-1 --mode 1920x1080 --pos 1920x0 --rotate normal
