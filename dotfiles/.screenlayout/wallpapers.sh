#!/usr/bin/env bash

# Dynamically load background with feh
feh_command="feh"
while read resolution; do
    echo "Assigning wallpaper-$resolution.jpg to $(xrandr | grep ' connected' | grep $resolution | awk '{print $1}')"
    feh_command="$feh_command --bg-fill ~/Pictures/wallpaper-$resolution.jpg"
done < <(xrandr --listmonitors | grep -oP '[0-9]+\/[0-9]+x[0-9]+\/[0-9]+' | awk -F'[/x]' '{printf "%sx%s\n", $1, $3}')

echo "$feh_command"
eval "$feh_command"
