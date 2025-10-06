{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    freecad.enable = lib.mkEnableOption "enable freecad";
  };

  config = lib.mkIf config.freecad.enable {
    #  	home.packages = with pkgs; {
    #
    # };
  };
}
