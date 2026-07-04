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

      extraConfig = builtins.readFile ./tmux/tmux.conf;

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

    programs.sesh = {
      enable = true;
    };
  };
}
