#!/usr/bin/env bash

case "$(printf "  Applications\nTools\nPower" | tofi  )" in
	__Applications) tofi-drun --drun-launch=true ;;
	tools) 
		case "$(printf "screenshot\npicker" | tofi )" in
			screenshot) notify-send "Screenshot" ;;
			picker) hyprpicker ;;

			*) exit 1 ;;
		esac ;;
	power) 
		case "$(printf "kill\nsleep\nreboot\nshutdown" | tofi --width=20% --height=20% --num-results=4 --prompt-text="" --placeholder-text="power option:" )" in
			kill) ps -u $USER -o pid,comm,%cpu,%mem | tofi --width=25% | awk '{print $1}' | xargs -r kill ;;
			sleep) systemctl suspend -i && hyprlock ;;
			reboot) systemctl reboot -i ;;
			shutdown) systemctl poweroff -i ;;

			*) exit 1 ;;
		esac ;;

	*) exit 1 ;;
esac

