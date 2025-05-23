{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    alacritty.enable = lib.mkEnableOption "enable alacritty";
  };

  config = lib.mkIf config.alacritty.enable {
    programs.alacritty = {
      enable = true;
      theme = "one_dark";
    };
  };
}
