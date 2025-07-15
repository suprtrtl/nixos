{
  config,
  pkgs,
  ...
}: {
  home.username = "suprtrtl";  # your WSL username
  home.homeDirectory = "/home/suprtrtl";

  home.stateVersion = "24.11";
  nixpkgs.config.allowUnfree = true;

  dconf.enable = false;

  # CLI tools that work well in WSL
  bundles.cli.misc.enable = true;
  neovim.enable = true;
  btop.enable = true;
  yazi.enable = true;
  oh-my-posh.enable = true;
  tmux.enable = true;
  zellij.enable = true;
  fzf.enable = true;
  zoxide.enable = true;

  # Skip GUI applications
  # alacritty.enable = true;
  # ghostty.enable = true;
  # obsidian.enable = true;
  # emacs.enable = true;

  home.packages = with pkgs; [
    # Add any WSL-specific packages
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.home-manager.enable = true;
}
