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
      font-awesome
      cm_unicode
      corefonts
    ];
  };
}
