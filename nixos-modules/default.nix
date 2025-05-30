{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    ./packages/essential.nix
    ./packages/fonts/essential.nix
  ];
}
