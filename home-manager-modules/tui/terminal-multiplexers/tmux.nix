{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    tmux.enable = lib.mkEnableOption "enable tmux";
  };

  config = lib.mkIf config.tmux.enable {
    programs.tmux = {
      enable = true;
      sensibleOnTop = true;
      mouse = true;
      baseIndex = 1;
      keyMode = "vi";

      shell = "${pkgs.zsh}/bin/zsh";

      shortcut = "s";

      tmuxinator = {
        enable = true;
      };

      plugins = with pkgs.tmuxPlugins; [
        {
          plugin = onedark-theme;
        }
      ];
    };
  };
}
