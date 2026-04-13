{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    ./display-managers/cosmic/cosmic.nix
    ./display-managers/niri/niri.nix

    ./packages/essential.nix
    ./packages/fonts/essential.nix
    ./packages/gui/spotify.nix

    ./services/fingerprint.nix
    ./services/docker.nix
    ./services/virtualization.nix
  ];
}
