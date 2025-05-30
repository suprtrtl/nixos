{
  pkgs,
  lib,
  config,
  ...
}: {
  fonts = {
    enableDefaultPackages = true;

    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      cm_unicode
      corefonts
    ];
  };
}
