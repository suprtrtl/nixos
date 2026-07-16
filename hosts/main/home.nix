{
  config,
  inputs,
  pkgs,
  ...
}: let
  stdenv.hostPlatform.system = "x86_64-linux";
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

  niri.enable = true;

  fzf.enable = true;
  zoxide.enable = true;

  bundles.cli.misc.enable = true;
  lazygit.enable = true;

  neovim.enable = true;
  vscode.enable = true;

  alacritty.enable = false;
  ghostty.enable = true;

  vlc.enable = true;

  lutris.enable = false;

  godot.enable = true;

  btop.enable = true;
  rmpc.enable = false;

  yazi.enable = true;

  oh-my-posh.enable = true;

  tmux.enable = true;
  herdr.enable = true;
  zellij.enable = false;

  robotics.enable = true;

  cheat.enable = true;

  opencode.enable = true;
  pi.enable = false;
  ollama.enable = false;

  programs.zen-browser.enable = true;
  programs.aichat.enable = true;
  # Not very Performant
  nyxt.enable = false;
  qutebrowser.enable = true;

  # User specific packages
  home.packages = with pkgs; [
    bluetui
    cava
    go
    inkscape
    libqalculate
    libsecret
    obsidian
    basalt
    prismlauncher
    protonvpn-gui
    steam-run
    vesktop
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
