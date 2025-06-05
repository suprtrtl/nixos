{
  pkgs,
  lib,
  config,
  ...
}: {
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
