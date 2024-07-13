#!/usr/bin/env bash

# Dynamically load background with feh
feh_command="feh --bg-fill"
while read resolution; do
    feh_command="$feh_command ~/Pictures/wallpaper-$resolution.jpg"
done < <(xrandr | grep ' connected' | grep -oP '[0-9]+x[0-9]+\+[0-9]+\+[0-9]+' | sort -t+ -nk3 | cut -d '+' -f 1)

echo "$feh_command"
eval "$feh_command"
