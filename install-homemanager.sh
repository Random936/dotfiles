#!/usr/bin/env bash

STATE_VERSION="24.05"

if [ $(id -u) != 0 ]; then
	echo "This script must be run as root."
	exit
fi

echo "Adding home-manager:${STATE_VERSION} to nix channels..."
nix-channel --add "https://github.com/nix-community/home-manager/archive/release-${STATE_VERSION}.tar.gz" home-manager

echo "Updating nix channels..."
nix-channel --update

echo "Installing home-manager..."
nix-shell '<home-manager>' -A install

echo "Finished..."
