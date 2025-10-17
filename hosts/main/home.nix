{
  config,
  inputs,
  pkgs,
  ...
}: let
  system = "x86_64-linux";
in {
  imports = [
    inputs.zen-browser.homeModules.beta
  ];

  # User Values
  home.username = "suprtrtl";
  home.homeDirectory = "/home/suprtrtl";

  home.stateVersion = "24.11";

  nixpkgs.config.allowUnfree = true;

  # Programs

  hyprland.enable = true;
  niri.enable = true;

  fzf.enable = true;
  zoxide.enable = true;

  bundles.cli.misc.enable = true;

  neovim.enable = true;
  emacs.enable = false;
  emacs.doom.enable = false;

  alacritty.enable = true;
  ghostty.enable = true;

  vlc.enable = true;

  btop.enable = true;
  rmpc.enable = true;

  yazi.enable = true;

  oh-my-posh.enable = true;

  tmux.enable = true;
  zellij.enable = false;

  robotics.enable = true;

  cheat.enable = true;

  programs.zen-browser.enable = true;
  # Not very Performant
  nyxt.enable = true;
  qutebrowser.enable = true;

  # User specific packages
  home.packages = with pkgs; [
    bluetui
    cava
    freecad
    impala
    kmonad
    obsidian
    python3
    python3Packages.pip
    protonvpn-cli
    protonvpn-gui
    steamcmd
    steam-tui
    webcord
  ];

  services.tldr-update.enable = true;

  # soure scripts
  home.file."bin" = {
    source = ./../../scripts;
    recursive = true;
  };

  # For dotfiles
  home.file = {};

  # ENV Variables
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.home-manager.enable = true;
}
