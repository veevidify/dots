#!/bin/bash

song=$(playerctl -p rhythmbox metadata xesam:title)
artist=$(playerctl -p rhythmbox metadata xesam:artist)
echo ${song:0:25} - $artist
