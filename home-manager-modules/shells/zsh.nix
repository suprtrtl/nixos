{
  pkgs,
  lib,
  config,
  ...
}: {
  programs.zsh = {
    enable = true;
    autosuggestion = {
      enable = true;
      highlight = "fg=#888888";
    };
    enableCompletion = true;

    shellAliases = {
      ll = "ls -l";
      fman = "compgen -c | fzf | xargs man";
      ":q" = "exit";
      q = "exit";
    };

    initContent = lib.mkOrder 1000 ''
      export PATH="$HOME/bin:$PATH"
    '';
  };

  home.file."bin" = {
    source = ./../../scripts;
    recursive = true;
  };
}
