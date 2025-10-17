{
  pkgs,
  lib,
  config,
  ...
}: {
  home.packages = with pkgs; [
    rofi
  ];

  home.file = {
    ".config/rofi/config.rasi".source = ./config.rasi;
  };
}
