{
  lib,
  config,
  ...
}: {
  options = {
    qutebrowser.enable = lib.mkEnableOption "enable qutebrowser browser";
  };

  config = lib.mkIf config.nyxt.enable {
    programs.qutebrowser.enable = true;
    home.file.".config/qutebrowser" = {
      source = ./qute;
      recursive = true;
    };
  };
}
