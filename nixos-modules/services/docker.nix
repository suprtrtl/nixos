{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    docker.enable = lib.mkEnableOption "enable docker";
  };

  config = lib.mkIf config.fingerprint.enable {
    environment.systemPackages = with pkgs; [
    ];

    virtualisation.docker = {
      enable = true;
    };

    users.users."suprtrtl".extraGroups = ["docker"];
  };
}
