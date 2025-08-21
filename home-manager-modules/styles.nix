{
  pkgs,
  lib,
  config,
  ...
}: {
  home.pointerCursor = {
    gtk.enable = true;

    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 16;
  };

  gtk = {
    enable = true;
    theme.name = "Adwaita";
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style.name = "adwaita-dark";
  };
}
