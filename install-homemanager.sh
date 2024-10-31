#!/usr/bin/env bash

STATE_VERSION="$1"

if [ $(id -u) != 0 ]; then
	echo "This script must be run as root."
	exit
fi

if [[ $1 == "" ]]; then
	echo "Usage: $0 <STATE_VERSION|unstable>"
	exit
fi

echo "Adding home-manager:${STATE_VERSION} to nix channels..."
if [[ $STATE_VERSION == "unstable" ]]; then
	nix-channel --add "https://github.com/nix-community/home-manager/archive/master.tar.gz" home-manager
else
	nix-channel --add "https://github.com/nix-community/home-manager/archive/release-${STATE_VERSION}.tar.gz" home-manager
fi

echo "Updating nix channels..."
nix-channel --update

echo "Installing home-manager..."
nix-shell '<home-manager>' -A install

echo "Finished..."
