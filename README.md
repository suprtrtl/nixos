# My NixOs Config

## Table of Contents

- [Installation](#installation)
    - [Cloning](#cloning)
    - [Git Setup](#git-setup)
- [Roadmap](#roadmap)
    - [Completed](#completed)

## Installation

### Cloning

Make sure you have `git` installed (`nix-shell -p git`)

```sh
cd ~
git clone https://github.com/suprtrtl/nixos.git
rm -f ~/nixos/hosts/main/hardware-configuration.nix
sudo cp -r /etc/nixos/hardware-configuration.nix ~/nixos/hosts/main
```

Change username and emails in various files

```sh
sudo nixos-rebuild switch --flake ~/nixos#main
```

### Git Setup

Make sure you setup git repository before running `rebuild-nixos.sh`

```sh
cd ~/nixos
git init
git remote add origin <remote url>
git add -A
git commit -m "initial commit"
git push origin main
```

Open up `scripts/rebuild-nixos.sh` and edit the variables at the top of the file to match your repo setup 

## Roadmap

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