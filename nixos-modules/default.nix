{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    ./hyprland/hyprland.nix
    ./niri/niri.nix

    ./packages/essential.nix
    ./packages/fonts/essential.nix
    ./packages/gui/spotify.nix

    ./services/fingerprint.nix
  ];
}
