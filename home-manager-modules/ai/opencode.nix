{
  lib,
  config,
  ...
}: {
  options = {
    opencode.enable = lib.mkEnableOption "enable opencode";
  };

  config = lib.mkIf config.lutris.enable {
    programs.opencode = {
      enable = true;
    };
  };
}
