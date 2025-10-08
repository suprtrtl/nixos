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

    home.file.".config/cheat/conf.yml".source = ./cheat/conf.yml;
    home.file.".config/cheat/cheatsheets/community" = {
      source = inputs.cheat-cheatsheets;
      recursive = true;
    };
    home.file.".config/cheat/cheatsheets/personal".source = ./cheat/cheatsheets/personal;
  };
}
