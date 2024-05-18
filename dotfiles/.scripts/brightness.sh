#!/usr/bin/env bash

if [[ $# != 1 ]]; then
    echo "Usage: $0 <brightness percentage>"
    echo "Example: $0 5 # Increase brighness by 5%"
    echo "Example: $0 -5 # Decrease brighness by 5%"
    exit 1
fi

file_root="/sys/class/backlight/$(ls /sys/class/backlight | head -n 1)"
max=$(cat "$file_root/max_brightness")
current=$(cat "$file_root/actual_brightness")
new=$(($current + ($max / 100 * $1)))


if [ "$new" -ge "$max" ]; then
    echo "$max" > $file_root/brightness
elif [ "$new" -le "0" ]; then
    echo "0" > $file_root/brightness
else
    echo "$new" > $file_root/brightness
fi
