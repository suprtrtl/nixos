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
      nerd-fonts.cousine
      nerd-fonts.iosevka
      font-awesome
      cm_unicode
      corefonts
    ];
  };
}
