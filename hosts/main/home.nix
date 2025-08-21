{
  config,
  pkgs,
  ...
}: {
  # User Values
  home.username = "suprtrtl";
  home.homeDirectory = "/home/suprtrtl";

  home.stateVersion = "24.11";

  nixpkgs.config.allowUnfree = true;

  # Programs

  fzf.enable = true;
  zoxide.enable = true;

  bundles.cli.misc.enable = true;

  neovim.enable = false;
  emacs.enable = false;
  emacs.doom.enable = false;

  obsidian.enable = false;

  alacritty.enable = true;
  ghostty.enable = true;

  btop.enable = true;
  rmpc.enable = true;

  yazi.enable = true;

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
