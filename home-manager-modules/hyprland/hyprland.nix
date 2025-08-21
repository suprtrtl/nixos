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

      extraConfig = "${builtins.readFile ./hyprland.conf}";
    };
  };
}
