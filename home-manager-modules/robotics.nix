{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    robotics.enable = lib.mkEnableOption "enable robotics software";
  };

  config = lib.mkIf config.robotics.enable {
    home.packages = with pkgs; [
      # freecad
      android-studio
      android-studio-tools
    ];
  };
}
