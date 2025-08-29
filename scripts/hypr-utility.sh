#!/usr/bin/env bash

case "$(printf "screenshot\npicker") | tofi -c ~/.config/tofi/hypr-utility" in
	screenshot) notify-send "Screenshot" ;;
	picker) hyprpicker ;;


	*) exit 1 ;;
esac
