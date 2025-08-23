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

    services.mako.enable = true;
    services.hyprpaper.enable = true;

    programs.waybar.enable = true;
    programs.tofi.enable = true;

    home.packages = with pkgs; [
      cliphist
      hyprpicker
    ];

    xdg.configFile = {
      "hypr/hyprpaper.conf".source = ./hypr/hyprpaper.conf;

      "tofi".source = ./tofi;

      "waybar/config".source = ./waybar/config;
      "waybar/styles.css".source = ./waybar/styles.css;
    };
  };
}
