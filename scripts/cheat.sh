#!/usr/bin/env bash

list=$(cht.sh :list)

if echo "$list" | grep -q "Internal Server Error"; then
	echo "An Error Occurred"
	exit
fi

selected=$(echo "$list" | fzf)
cht.sh "$selected"
