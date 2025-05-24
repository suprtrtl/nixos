{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    lazygit.enable = lib.mkEnableOption "enable lazygit";
  };

  config = lib.mkIf config.lazygit.enable {
    programs.lazygit.enable = true;
  };

}
