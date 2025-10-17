{
  pkgs,
  lib,
  config,
  ...
}: {
  programs.tofi.enable = true;

  xdg.configFile = {
    "tofi/config" = ./config;
  };
}
