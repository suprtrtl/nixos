#!/usr/bin/env bash

case "$(printf "screenshot\npicker") | tofi" in
	screenshot) notify-send "Screenshot" ;;
	picker) hyprpicker ;;


	*) exit 1 ;;
esac
