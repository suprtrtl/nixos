{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    nyxt.enable = lib.mkEnableOption "enable nyxt browser";
  };

  config = lib.mkIf config.nyxt.enable {
    home.packages = with pkgs; [
      nyxt
    ];
  };
}
