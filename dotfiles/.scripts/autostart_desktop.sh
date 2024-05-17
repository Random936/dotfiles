#!/bin/bash

for file in $HOME/.config/autostart/*; do
    exec_line=$(cat "$file" | grep '^Exec' | cut -d '=' -f2-)
    eval "$exec_line"
done
