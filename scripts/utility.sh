#!/usr/bin/env bash

case "$(printf "applications\ntools\npower" | tofi  )" in
	applications) tofi-drun --drun-launch ;;
	tools) 
		case "$(printf "screenshot\npicker" | tofi )" in
			screenshot) notify-send "Screenshot" ;;
			picker) hyprpicker ;;

			*) exit 1 ;;
		esac ;;

	*) exit 1 ;;
esac

