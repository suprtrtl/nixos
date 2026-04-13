{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    cosmic.enable = lib.mkEnableOption "enable cosmic";
  };

  config = lib.mkIf config.cosmic.enable {
    services.desktopManager.cosmic.enable = true;
    services.desktopManager.cosmic.xwayland.enable = true;

    services.system76-scheduler.enable = true;
  };
}
