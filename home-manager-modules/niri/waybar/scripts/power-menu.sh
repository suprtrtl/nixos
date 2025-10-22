#!/usr/bin/env bash

case "$(printf "kill\nsleep\nreboot\nshutdown" | rofi -dmenu -i -p "Power Option" -width 20% -height 20% -num-results 4)" in
	kill) ps -u $USER -o pid,comm,%cpu,%mem | rofi -dmenu -i -p "Select Process to Kill" -width 25% | awk '{print $1}' | xargs -r kill ;;
	sleep) systemctl suspend -i && hyprlock ;;
	reboot) systemctl reboot -i ;;
	shutdown) systemctl poweroff -i ;;
	*) exit 1 ;;
esac
