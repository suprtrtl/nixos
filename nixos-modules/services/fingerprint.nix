{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    fingerprint.enable = lib.mkEnableOption "enable fingerprint";
  };

  config = lib.mkIf config.fingerprint.enable {
    systemd.services.fprintd = {
      wantedBy = ["multi-user.target"];
      serviceConfig.Type = "simple";
    };

    services.fprintd.enable = true;
    # services.fprintd.tod.enable = true;
    #
    # services.fprintd.tod.driver = pkgs.libfprint-2-tod1-goodix;
  };
}
