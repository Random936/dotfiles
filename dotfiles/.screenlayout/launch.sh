#!/usr/bin/env bash

function load_script() {
    if [ -f "$1" ]; then
        $1
    fi
}

load_script "$HOME/.screenlayout/layout.sh" # screen layout script
load_script "$HOME/.screenlayout/wallpapers.sh" # wallpapers script

