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

                unbind %
                unbind \"

                bind v split-window -h
                bind - split-window -v

                            bind -r H resize-pane -L 5
                            bind -r J resize-pane -D 5
                            bind -r K resize-pane -U 5
                            bind -r L resize-pane -R 5

        bind-key "T" run-shell "sesh connect \"$(
          sesh list --icons | fzf-tmux -p 80%,70% \
            --no-sort --ansi --border-label ' sesh ' --prompt '⚡  ' \
            --header '  ^a all ^t tmux ^g configs ^x zoxide ^d tmux kill ^f find' \
            --bind 'tab:down,btab:up' \
            --bind 'ctrl-a:change-prompt(⚡  )+reload(sesh list --icons)' \
            --bind 'ctrl-t:change-prompt(🪟  )+reload(sesh list -t --icons)' \
            --bind 'ctrl-g:change-prompt(⚙️  )+reload(sesh list -c --icons)' \
            --bind 'ctrl-x:change-prompt(📁  )+reload(sesh list -z --icons)' \
            --bind 'ctrl-f:change-prompt(🔎  )+reload(fd -H -d 2 -t d -E .Trash . ~)' \
            --bind 'ctrl-d:execute(tmux kill-session -t {2..})+change-prompt(⚡  )+reload(sesh list --icons)' \
            --preview-window 'right:55%' \
            --preview 'sesh preview {}'
        )\""
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

    programs.sesh = {
      enable = true;
    };
  };
}
