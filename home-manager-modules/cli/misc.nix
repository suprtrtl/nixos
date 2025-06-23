{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    bundles.cli.misc.enable = lib.mkEnableOption "enables misc bundle";
  };

  config = lib.mkIf config.bundles.cli.misc.enable {
    home.packages = with pkgs; [
      astroterm
      pastel
    ];
  };
}
