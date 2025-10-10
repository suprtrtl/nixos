{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    vlc.enable = lib.mkEnableOption "enable vlc media player";
  };

  config = lib.mkIf config.vlc.enable {
    home.packages = with pkgs; [
      vlc
    ];
  };
}
