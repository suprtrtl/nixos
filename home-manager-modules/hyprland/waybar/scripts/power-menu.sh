#!/usr/bin/env bash

case "$(printf "kill\nsleep\nreboot\nshutdown" | tofi --anchor=top-left --width=5%)" in
	kill) ps -u $USER -o pid,comm,%cpu,%mem | tofi | awk '{print $1}' | xargs -r kill ;;
	sleep) systemctl hibernate -i ;;
	reboot) systemctl reboot -i ;;
	shutdown) systemctl poweroff -i ;;

	*) exit 1 ;;
esac
