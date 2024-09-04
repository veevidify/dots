#!/bin/bash
#==================================#
#     Caligula's dmenu script.     #
#==================================#

# Set the custom colors from wal.
source "$HOME/scripts/antium-colors.sh"

# For classic Dmenu.
dmenu_run -b -nb "$color0" -nf "$color7" -sb "$color1" -sf "$color7" -fn Inconsolata-11:normal

