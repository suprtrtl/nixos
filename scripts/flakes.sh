#!/usr/bin/env bash

FLAKES_PATH="$HOME/nixos/scripts/flakes"
flake=$(basename "$(find "$FLAKES_PATH")" | fzf)

cp "$FLAKES_PATH/$flake" flake.nix
