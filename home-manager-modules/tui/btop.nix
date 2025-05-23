{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    btop.enable = lib.mkEnableOption "enable btop";
  };

  config = lib.mkIf config.btop.enable {
    programs.btop = {
      enable = true;
      settings = {
        color_theme = "onedark";
        theme_background = false;
      };
    };
  };
}
