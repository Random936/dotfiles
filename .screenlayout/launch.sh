#!/bin/bash

script="$HOME/.screenlayout/layout.sh"

if [ -f "$script" ]; then
   $script
fi

feh --bg-scale $HOME/Pictures/wallpaper.jpg
