{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    cheat.enable = lib.mkEnableOption "enable lazygit";
  };

  config = lib.mkIf config.cheat.enable {
    home.packages = with pkgs; [
      cheat
    ];

    xdg.configFile."cheat".source = ./cheat;
  };
}
