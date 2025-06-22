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
    };

    initContent = lib.mkOrder 1000 ''
      export PATH="$HOME/bin:$PATH"
    '';
  };

  home.file."bin/rebuild-nixos".source = ./../../rebuild-nixos.sh;
}
