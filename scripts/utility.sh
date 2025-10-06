#!/usr/bin/env bash

case "$(printf "  Applications\n  Tools\n󱄅  Nix\n󰞋  Help\n  Power" | tofi --width=20% )" in
	"  Applications") tofi-drun --drun-launch=true ;;
	"  Tools") 
		case "$(printf "screenshot\npicker" | tofi )" in
			screenshot) notify-send "TODO" ;;
			picker) exit && hyprpicker ;;

			*) exit 1 ;;
		esac ;;
	"󱄅  Nix")
		case "$(printf "  Temp Package\n  NixOS Manual\n  NixOS Config Options\n  Home Manager Config Options" | tofi )" in
			"  Temp Package") notify-send "TODO" ;;
			"  NixOS Manual") nixos-help && notify-send "Opened in Browser" ;;
			"  NixOS Config Options") notify-send "TODO" ;;
			"  Home Manager Config Options") notify-send "TODO" ;;

			*) exit 1 ;;
		esac ;;
	"󰞋  Help") ;;
	"  Power") 
		case "$(printf "kill\nsleep\nreboot\nshutdown" | tofi --width=20% --height=20% --num-results=4 --prompt-text="" --placeholder-text="power option:" )" in
			kill) ps -u $USER -o pid,comm,%cpu,%mem | tofi --width=25% | awk '{print $1}' | xargs -r kill ;;
			sleep) systemctl suspend -i && hyprlock ;;
			reboot) systemctl reboot -i ;;
			shutdown) systemctl poweroff -i ;;

			*) exit 1 ;;
		esac ;;

	*) exit 1 ;;
esac

