{
  config,
  pkgs,
  ...
}: {
  # User Values
  home.username = "suprtrtl";
  home.homeDirectory = "/home/suprtrtl";

  home.stateVersion = "24.11"; 


  # Programs

  fzf.enable = true;
  zoxide.enable = true;

  neovim.enable = true;
  emacs.enable = true;
  emacs.doom.enable = true;

  gtk = {
    enable = true;
    theme.name = "adw-getk3";
  };

  alacritty.enable = true;
  ghostty.enable = true;

  btop.enable = true;
  rmpc.enable = true;

  oh-my-posh.enable = true;

  tmux.enable = true;
  zellij.enable = true;

  # User specific packages
  home.packages = with pkgs; [];

  # For dotfiles
  home.file = {};

  # ENV Variables
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.home-manager.enable = true;
}
