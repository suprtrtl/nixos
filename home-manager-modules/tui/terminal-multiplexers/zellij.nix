{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    zellij.enable = lib.mkEnableOption "enables zellij";
  };

  config = lib.mkIf config.zellij.enable {
    programs.zellij.enable = true;

    home.file.".config/zellij/config.kdl".source = ./zellij/config.kdl;
    home.file.".config/zellij/plugins/room.wasm".source = pkgs.fetchurl {
      url = "https://github.com/rvcas/room/releases/latest/download/room.wasm";
      hash = "sha256-t6GPP7OOztf6XtBgzhLF+edUU294twnu0y5uufXwrkw=";
    };
  };
}
