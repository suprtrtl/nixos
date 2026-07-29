#!/usr/bin/env bash

selected=$(cht.sh :list | fzf)
cht.sh "$selected"
