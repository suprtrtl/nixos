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
    programs.ghostty = {
      enable = true;

      enableZshIntegration = true;

      settings = {
        theme = "One Half Dark";
        font-size = 10;
      };
    };
  };
}
