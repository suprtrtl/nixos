#!/usr/bin/env bash

case "$(printf "  Applications\n  Tools\n󱄅  Nix\n  Learn\n  Power" | tofi --width=20% )" in
	"  Applications") tofi-drun --drun-launch=true ;;
	"  Tools") 
		case "$(printf "screenshot\npicker" | tofi )" in
			screenshot) notify-send "TODO" ;;
			picker) hyprpicker ;;

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
	"  Learn")
		case "$(printf "󰈙  man\n  TLDR\n  Cheat\n󰖟  cheat.sh (Online)\n󰭤  Wikis" | tofi)" in
			"󰈙  man") ghostty -e sh -c "echo "Select man file" && man \$(man -k . | tofi --width=50% --placeholder-text='Search or Input man page' --fuzzy-match=false | awk '{section=\$2; gsub(/[()]/, \"\", section); print section, \$1}')" ;;
			"  TLDR") ghostty -e sh -c "tldr -c "$(tldr -l | tofi --width=20% --placeholder-text="download or search tldr's" --require-match=false | awk '{print $1}' )" | less -R" ;;
			"󰖟  cheat.sh (Online)") ghostty -e sh -c "curl cheat.sh/"$(curl cheat.sh/:list | tofi --width=20% --placeholder-text="search cheat.sh or enter known menu:")" | less -R" ;;
			"  Cheat") notify-send "TODO" ;;
			"󰭤  Wikis") notify-send "TODO" ;;

			*) exit 1 ;;
		esac ;;
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

