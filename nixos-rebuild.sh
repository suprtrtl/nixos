#!/usr/bin/env bash

set -e

pushd /etc/nixos/

if git diff --quiet '*.nix' or git diff --quiet '*.lua'; then
	echo "no changes detected, exiting..."
	popd
	exit 0
fi

alejandra . &>/dev/null \
	|| (alejandra . ; echo "formatting failed" && exit 2)


git diff -U0 '*.nix'
git diff -U0 '*.lua'

echo "Nixos Rebuilding..."

sudo nixos-rebuild switch --flake /etc/nixos#vm &>nixos-switch.log || (cat nixos-switch.log | grep --color error && exit 1)

# Get current generation metadata
current=$(nixos-rebuild list-generations | grep current)

# Commit all changes witih the generation metadata
git commit -am "$current"

# Back to where you were
popd

# Notify all OK!
notify-send -e "NixOS Rebuilt OK!" --icon=software-update-available
