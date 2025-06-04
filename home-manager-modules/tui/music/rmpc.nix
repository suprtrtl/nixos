{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    rmpc.enable = lib.mkEnableOption "enables rmpc";
  };

  config = lib.mkIf config.rmpc.enable {
    programs.rmpc = {
      enable = true;
      #    config = ''
      #      ${builtins.readFile ./rmpc/config.ron}
      #    '';
    };

    services.mpd = {
      enable = true;
      musicDirectory = "${config.home.homeDirectory}/Music";
    };
  };
}
