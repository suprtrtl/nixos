{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    ghostty.enable = lib.mkEnableOption "enable ghostty";
  };

  config = lib.mkIf config.ghostty.enable {
    programs.ghostty.enable = true;

    xdg.configFile."ghostty".source = ./ghostty;
    # xdg.configFile."ghostty/shaders".source = ./ghostty/shaders;
  };
}
