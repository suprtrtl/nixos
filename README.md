# My NixOs Config

## Installation

```sh
cd ~
git clone https://github.com/suprtrtl/nixos.git
rm -f ~/nixos/hosts/main/hardware-configuration.nix
sudo cp -r /etc/nixos/hardware-configuration.nix ~/nixos/hosts/main
sudo nixos-rebuild switch --flake ~/nixos#main
```

## ROADMAP

- [ ] Add Update flag to rebuild script (nix flake update)
- [ ] Add push and pull git flags to rebuild script (-p | pull from github, -P | dont push to github)
- [ ] Prism Launcher
- [ ] Seperate `essentials.nix` into a folder with sub category folders (eg. `essentials/dev.nix`)
- [ ] refactor `nixos-modules/` to actually be module based (eg. nix module for `systemd-boot`)

### Completed

- [x] Obsidian
- [x] Yazi File Manager
- [x] Configure Hyprland (can't test, on VM)
- [x] Configure Waybar ([inspiration](https://github.com/sejjy/mechabar))
- [x] Configure ~~Wofi~~ Tofi
- [x] Steam
- [x] Discord