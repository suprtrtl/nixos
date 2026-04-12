waybar -c ~/.config/waybar/config.niri.jsonc -s ~/.config/waybar/style.niri.css &
awww-daemon &
awww img ~/wallpapers/mountain.png
swayidle -w \
  timeout 300 'swaylock &' \
  timeout 330 'niri msg action power-off-monitors' \
  resume 'niri msg action power-on-monitors' \
  before-sleep 'swaylock &'
