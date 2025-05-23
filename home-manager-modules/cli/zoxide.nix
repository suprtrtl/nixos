{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    zoxide.enable = lib.mkEnableOption "enable zoxide";
  };

  config = lib.mkIf config.zoxide.enable {
    programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
      options = [
        "--cmd cd"
      ];
    };

    home.packages = with pkgs; [
      fzf
    ];
  };
}
