#!/usr/bin/env bash

FLAKES_PATH="$HOME/nixos/scripts/flakes/"
flake=$(find "$FLAKES_PATH" -name "*.nix" | fzf --preview 'bat  --color=always {}');

if [[ "$flake" != "" ]]; then
	cp "$flake" flake.nix
fi
