#!/bin/bash

script="$HOME/.screenlayout/layout.sh"

if [ -f "$script" ]; then
   $script
fi

nitrogen --restore
