{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  options = {
    niri.enable = lib.mkEnableOption "enable niri home manager";
  };

  config = lib.mkIf config.niri.enable {
    services.mako = {
      enable = true;
      settings = {
        default-timeout = 1500;
      };
    };

    programs.waybar.enable = true;

    home.packages = with pkgs; [
      cliphist
      helvum
      lm_sensors
      rofi
    ];

    xdg.configFile = {
      "niri".source = ./niri;

      "waybar/config.niri.jsonc".source = ./waybar/config.jsonc;
      "waybar/style.niri.css".source = ./waybar/style.css;

      "waybar/niri-scripts" = {
        source = ./waybar/scripts;
        recursive = true;
      };
    };
  };
}
