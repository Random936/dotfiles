#!/bin/bash

# Load screen layout script if it exists
script="$HOME/.screenlayout/layout.sh"
if [ -f "$script" ]; then
   $script
fi

# Dynamically load background with feh
feh_command="feh --bg-fill"
while read resolution; do
    feh_command="$feh_command ~/Pictures/wallpaper-$resolution.jpg"
done < <(xrandr | grep ' connected' | grep -oP '[0-9]+x[0-9]+\+[0-9]+\+[0-9]+' | cut -d '+' -f 1)

echo "$feh_command"
eval "$feh_command"
