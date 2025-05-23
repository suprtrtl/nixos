{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    main_fonts.enable = lib.mkEnableOption "enables fonts";
  };

  config = lib.mkIf config.main_fonts.enable {
    fonts = {
      enableDefaultPackages = true;

      packages = with pkgs; [
        nerd-fonts.jetbrains-mono
        cm_unicode
        corefonts
      ];
    };
  };
}
