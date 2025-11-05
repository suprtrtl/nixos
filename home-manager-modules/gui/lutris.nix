{
  pkgs,
  lib,
  config,
  osConfig,
  ...
}: {
  options = {
    lutris.enable = lib.mkEnableOption "enable vlc media player";
  };

  config = lib.mkIf config.lutris.enable {
    programs.lutris = {
      enable = true;
      extraPackages = with pkgs; [
        mangohud
        winetricks
        gamescope
        gamemode
        umu-launcher
      ];
      protonPackages = with pkgs; [
        proton-ge-bin
      ];
      steamPackage = osConfig.programs.steam.package;
      winePackages = with pkgs; [
        wineWowPackages.stable
      ];
    };
  };
}
