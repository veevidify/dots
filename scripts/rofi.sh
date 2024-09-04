#!/bin/bash

rofi -i \
	-levenshtein-sort \
	-font "Font Awesome 16" \
	-lines 10 \
	-columns 1 \
	-width 1280 \
	-location 0 \
	-padding-bottom 20 \
	-bw 3 \
	-hide-scrollbar \
	-theme $HOME/.config/custom/material-warm.rasi \
	-show-icons \
	-drun-icon-theme hicolor \
	-combi-modi drun,run \
	-show combi
