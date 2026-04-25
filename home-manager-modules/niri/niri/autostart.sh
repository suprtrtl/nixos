waybar -c ~/.config/waybar/config.niri.jsonc -s ~/.config/waybar/style.niri.css &
awww-daemon &
awww img ~/wallpapers/mountain.png
swayidle -w \
  timeout 300 'niri msg action power-off-monitors' \
  timeout 360 'swaylock &' \
  timeout 600 'systemctl suspend -i' \
  resume 'niri msg action power-on-monitors' \
  before-sleep 'swaylock &'
