{
  pkgs,
  lib,
  config,
  ...
}: {
  programs.fish = {
    enable = true;
    shellAliases = {
      ll = "ls -l";
      fman = "complete -C '' | fzf | xargs man";
    };
    interactiveShellInit = ''
      set -g fish_color_autosuggestion 888888
      fish_add_path $HOME/bin
    '';
  };
  home.file."bin" = {
    source = ./../../scripts;
    recursive = true;
  };
}
