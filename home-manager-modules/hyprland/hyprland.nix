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
        default-timeout = 1500;
      };
    };
    services.hyprpaper.enable = true;

    programs.waybar.enable = true;
    programs.hyprlock.enable = true;

    # Tofi
    programs.tofi.enable = true;

    # Refresh Cache
    home.activation = {
      # https://github.com/philj56/tofi/issues/115#issuecomment-1701748297
      regenerateTofiCache = lib.hm.dag.entryAfter ["writeBoundary"] ''
        tofi_cache=${config.xdg.cacheHome}/tofi-drun
        [[ -f "$tofi_cache" ]] && rm "$tofi_cache"
      '';
    };
    home.packages = with pkgs; [
      cliphist
      helvum
      hyprpicker
      hyprshot
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
