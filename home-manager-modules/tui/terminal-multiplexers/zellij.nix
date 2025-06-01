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
    home.file.".config/zellij/plugins/zellij_forgot.wasm".source = pkgs.fetchurl {
      url = "https://github.com/karimould/zellij-forgot/releases/latest/download/zellij_forgot.wasm";
      hash = "sha256-MRlBRVGdvcEoaFtFb5cDdDePoZ/J2nQvvkoyG6zkSds=";
    };
  };
}
