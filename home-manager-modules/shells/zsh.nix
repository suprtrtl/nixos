{
  pkgs,
  lib,
  config,
  ...
}: {
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;

    oh-my-zsh = {
      enable = true;
      theme = "af-magic";
      plugins = [
        "git"
        "sudo"
        "tmux"
      ];
    };
  };
}
