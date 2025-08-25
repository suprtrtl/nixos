{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  options = {
    hyprland.enable = lib.mkEnableOption "enable hyprland home manager";
  };

  config = lib.mkIf config.hyprland.enable {
    wayland.windowManager.hyprland = {
      enable = true;

      extraConfig = "${builtins.readFile ./hypr/hyprland.conf}";
    };

    services.mako = {
      enable = true;
      settings = {
        default-timeout = 500;
      };
    };
    services.hyprpaper.enable = true;

    programs.waybar.enable = true;
    programs.tofi.enable = true;

    home.packages = with pkgs; [
      cliphist
      hyprpicker
      lm_sensors
    ];

    xdg.configFile = {
      "hypr/hyprpaper.conf".source = ./hypr/hyprpaper.conf;

      "tofi".source = ./tofi;

      "waybar/config.jsonc".source = ./waybar/config.jsonc;
      "waybar/style.css".source = ./waybar/style.css;

      "waybar/scripts" = {
        source = ./waybar/scripts;
        recursive = true;
      };
    };
  };
}
