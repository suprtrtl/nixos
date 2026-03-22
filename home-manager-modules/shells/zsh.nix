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
      "code ." = "codium .";
      nd = "nix develop -c zsh";
    };

    initContent = lib.mkOrder 1000 ''
         export PATH="$HOME/bin:$HOME/.cargo/bin:$PATH"
      function gi() { curl -sLw \"\\\n\" https://www.toptal.com/developers/gitignore/api/\$@ ;}
    '';
  };
}
