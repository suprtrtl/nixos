{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    spotify.enable = lib.mkEnableOption "enables spotify";
  };

  config = lib.mkIf config.spotify.enable {
    environment.systemPackages = with pkgs; [
      spotify
    ];

    networking.firewall.allowedTCPPorts = [57621];
    networking.firewall.allowedUDPPortRanges = [
      {
        from = 5353;
        to = 5353;
      }
    ];
  };
}
