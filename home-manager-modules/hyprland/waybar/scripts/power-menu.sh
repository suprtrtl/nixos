#!/usr/bin/env bash

case "$(printf "kill\nsleep\nreboot\nshutdown" | tofi --anchor=top-right --width=7% --num-results=4 --prompt-text="" )" in
	kill) ps -u $USER -o pid,comm,%cpu,%mem | tofi | awk '{print $1}' | xargs -r kill ;;
	sleep) systemctl hibernate -i ;;
	reboot) systemctl reboot -i ;;
	shutdown) systemctl poweroff -i ;;

	*) exit 1 ;;
esac
