{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    ./hyprland/hyprland.nix

    ./packages/essential.nix
    ./packages/fonts/essential.nix
  ];
}
