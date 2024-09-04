#!/bin/sh

SCRIPTPATH=$(realpath "$0")
SCRIPTPATH="$HOME/scripts/lockscr"

IMAGE="/tmp/lock.png"
LOCKSCREEN_IMAGE="$HOME/Pictures/FirewatchSunsetYellow.jpg"

if [ ! -e "$IMAGE" ]; then
	echo "Image not found, creating new one"

	# Get copy of wallpaper
	WALLP="$LOCKSCREEN_IMAGE"
	cp $WALLP $IMAGE

	# Scale it to fit screen
	convert "$IMAGE" -resize 1920x1080^ -gravity center -extent 1920x1080 -blur 0x8 $IMAGE

	# Add Lock Icon
	ICON_ORIG="$SCRIPTPATH/lock_white.png"
	#ICON="/tmp/lock_icon.png"
	cp $ICON_ORIG $ICON
	convert "$ICON" -resize 120x120 "$ICON"
	convert "$IMAGE" "$ICON" -gravity Center -composite "$IMAGE"
fi

i3lock
