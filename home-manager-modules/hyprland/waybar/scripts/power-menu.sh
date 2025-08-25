#!/usr/bin/env bash

case "$(printf "kill\nsleep\nreboot\nshutdown" | tofi --anchor=top-right --width=8% --height=12% --num-results=4 --prompt-text="" --placeholder-text="power option:" --margin-top=42 --margin-right=5 )" in
	kill) ps -u $USER -o pid,comm,%cpu,%mem | tofi --width=25% | awk '{print $1}' | xargs -r kill ;;
	sleep) systemctl suspend -i && hyprlock ;;
	reboot) systemctl reboot -i ;;
	shutdown) systemctl poweroff -i ;;

	*) exit 1 ;;
esac
