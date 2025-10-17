{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    niri.enable = lib.mkEnableOption "enable niri";
  };

  config = lib.mkIf config.niri.enable {
    programs.niri.enable = true;

    environment.systemPackages = with pkgs; [
      alacritty
      fuzzel
      swaylock
      xwayland-satellite
    ];

    hardware = {
      opengl.enable = true;
    };

    xdg.portal.enable = true;
    xdg.portal.extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-gnome
      pkgs.gnome-keyring
    ];
  };
}
