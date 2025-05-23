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
        theme = "OneHalfDark";
        font-size = 10;
      };
    };
  };
}
