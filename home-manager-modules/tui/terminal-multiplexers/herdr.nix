{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    herdr.enable = lib.mkEnableOption "enables herdr";
  };

  config = lib.mkIf config.herdr.enable {
    home.packages = with pkgs; [
      herdr
    ];
    xdg.configFile = {
      "herdr/config.toml".source = ./herdr/config.toml;
    };
  };
}
