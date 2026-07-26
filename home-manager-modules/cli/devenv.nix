{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    devenv.enable = lib.mkEnableOption "enable devenv";
  };

  config = lib.mkIf config.devenv.enable {
    programs.devenv = {
      enable = true;
      package = pkgs.devenv;
      enableZshIntegration = true;
    };
  };
}
