{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  options = {
    cheat.enable = lib.mkEnableOption "enable cheat cli";
  };

  config = lib.mkIf config.cheat.enable {
    home.packages = with pkgs; [
      cheat
    ];

    xdg.configFile."cheat".source = ./cheat;
    home.file.".config/cheat/cheatsheets/community" = {
      source = inputs.cheat-cheatsheets;
      recursive = true;
    };
    # xdg.configFile."cheat/cheatsheets/personal".source = ./cheat/cheatsheets/personal;
  };
}
