{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    discord.enable = lib.mkEnableOption "enables discord (webcord)";
  };

  config = lib.mkIf config.discord.enable {
    home.packages = with pkgs; [
      webcord
    ];
  };
}
