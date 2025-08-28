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
      terminal = "screen-256color";

      shortcut = "s";

      extraConfig = ''
         	set-option -g status-position top
        set-option -g allow-passthrough all
      '';

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
