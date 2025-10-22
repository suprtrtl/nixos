#!/usr/bin/env bash

case "$(printf "  Applications\n  Tools\n󱄅  Nix\n  Learn\n  Power" | rofi -dmenu -i -p "Select Option" -width 20%)" in
    "  Applications") 
        rofi -show drun
		;;
    "  Tools")
        case "$(printf "  Resources\n  Screenshot\n  Picker\n  Wifi\n󰂯  Bluetooth" | rofi -dmenu -i -p "Select Tool" -width 20%)" in
            "  Resources") ghostty -e "btop" ;;
            "  Screenshot") notify-send "TODO" ;;
            "  Picker") hyprpicker ;;
            "  Wifi") ghostty -e "impala" ;;
            "󰂯  Bluetooth") ghostty -e "bluetui" ;;
            *) exit 1 ;;
        esac
        ;;
    "󱄅  Nix")
        case "$(printf "  Temp Package\n  NixOS Manual\n  NixOS Config Options\n  Home Manager Config Options\n󱞱  Back" | rofi -dmenu -i -p "Select Nix Option" -width 20%)" in
            "  Temp Package") notify-send "TODO" ;;
            "  NixOS Manual") nixos-help && notify-send "Opened in Browser" ;;
            "  NixOS Config Options") notify-send "TODO" ;;
            "  Home Manager Config Options") notify-send "TODO" ;;
            "󱞱  Back") utility.sh ;;
            *) exit 1 ;;
        esac
        ;;
    "  Learn")
        case "$(printf "󰈙  man\n  TLDR\n󰖟  cheat.sh (Online)\n  Cheat\n󰭤  Wikis" | rofi -dmenu -i -p "Learn Option" -width 20%)" in
            "󰈙  man") ghostty -e sh -c "man \$(man -k . | rofi -dmenu -i -p 'Search or Input man page' -fuzzy -width 50% | awk '{section=\$2; gsub(/[()]/, \"\", section); print section, \$1}')" ;;
            "  TLDR") ghostty -e sh -c "tldr -c \"\$(tldr -l | rofi -dmenu -i -p 'download or search tldr\'s' | awk '{print $1}')\" | less -R" ;;
            "󰖟  cheat.sh (Online)") ghostty -e sh -c "curl cheat.sh/$(curl cheat.sh/:list | rofi -dmenu -i -p 'search cheat.sh or enter known menu:') | less -R" ;;
            "  Cheat") ghostty -e sh -c "cheat -c \"\$(cheat -l | rofi -dmenu -i -p 'select cheatsheet' | awk '{print $1}')\"" ;;
            "󰭤  Wikis") notify-send "TODO" ;;
            *) exit 1 ;;
        esac
        ;;
    "  Power")
        case "$(printf "kill\nsleep\nreboot\nshutdown" | rofi -dmenu -i -p "Power Option" -width 20% -height 20% -num-results 4)" in
            kill) ps -u $USER -o pid,comm,%cpu,%mem | rofi -dmenu -i -p "Select Process to Kill" -width 25% | awk '{print $1}' | xargs -r kill ;;
            sleep) systemctl suspend -i && hyprlock ;;
            reboot) systemctl reboot -i ;;
            shutdown) systemctl poweroff -i ;;
            *) exit 1 ;;
        esac
        ;;
    *) exit 1 ;;
esac
