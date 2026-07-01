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

      shortcut = "a";

      extraConfig = ''
              set-option -g status-position top
              set-option -g allow-passthrough all

        bind h select-pane -L
        bind j select-pane -D
        bind k select-pane -U
        bind l select-pane -R

              bind -r H resize-pane -L 5
              bind -r J resize-pane -D 5
              bind -r K resize-pane -U 5
              bind -r L resize-pane -R 5
      '';

      plugins = with pkgs.tmuxPlugins; [
        {
          plugin = onedark-theme.overrideAttrs (old: {
            postInstall =
              (old.postInstall or "")
              + ''
                sed -i '1s|#!/bin/bash|#!${pkgs.bash}/bin/bash|' \
                  $out/share/tmux-plugins/onedark-theme/tmux-onedark-theme.tmux
              '';
          });
        }
        {
          plugin = resurrect;
        }
      ];
    };
  };
}
