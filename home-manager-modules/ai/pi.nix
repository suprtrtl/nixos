{
  lib,
  config,
  ...
}: {
  options = {
    pi.enable = lib.mkEnableOption "enable pi coding agent";
  };

  config = lib.mkIf config.pi.enable {
    programs.pi-coding-agent = {
      enable = true;
    };
  };
}
