#!/usr/bin/env bash

case "$(printf "kill\nsleep\nreboot\nshutdown" | tofi)" in
	kill) ps -u $USER -o pid,comm,%cpu,%mem | tofi | awk '{print $1}' | xargs -r kill ;;
	sleep) systemctl hibernate -i ;;
	reboot) systemctl reboot -i ;;
	shutdown) systemctl poweroff -i ;;

	*) exit 1 ;;
esac
