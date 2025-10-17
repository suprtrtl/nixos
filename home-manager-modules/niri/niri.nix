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
      lm_sensors
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
