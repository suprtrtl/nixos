{
  lib,
  config,
  ...
}: {
  options = {
    opencode.enable = lib.mkEnableOption "enable opencode";
  };

  config = lib.mkIf config.opencode.enable {
    programs.opencode = {
      enable = true;
      context = ''
         # IMPORTANT
         	- Please try to not access any files when possible if necessary ask for explicit permission
        - Be concise and simple
      '';
    };
  };
}
