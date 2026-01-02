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

  hyprland.enable = false;
  niri.enable = true;

  fzf.enable = true;
  zoxide.enable = true;

  bundles.cli.misc.enable = true;
  lazygit.enable = true;

  neovim.enable = true;
  vscode.enable = true;
  emacs.enable = false;
  emacs.doom.enable = false;

  alacritty.enable = false;
  ghostty.enable = true;

  vlc.enable = true;

  lutris.enable = true;

  godot.enable = true;

  btop.enable = true;
  rmpc.enable = true;

  yazi.enable = true;

  oh-my-posh.enable = true;

  tmux.enable = true;
  zellij.enable = false;

  robotics.enable = true;

  cheat.enable = true;

  programs.zen-browser.enable = true;
  programs.aichat.enable = true;
  # Not very Performant
  nyxt.enable = false;
  qutebrowser.enable = true;

  # programs.neomutt.enable = true;

  # accounts.email = {
  #   maildirBasePath = "Maildir"; # gives ~/Maildir
  #   accounts.personal = {
  #     primary = true;
  #     address = "owen.rodway@gmail.com";
  #     userName = "owen.rodway@gmail.com";
  #     realName = "Owen Rodway";
  #
  #     flavor = "gmail.com"; # pulls correct IMAP/SMTP defaults
  #
  #     # Ensure there is a maildir for this account
  #     mbsync = {
  #       enable = true;
  #       create = "maildir";
  #     };
  #
  #     # Optional: override subdirectory name under ~/Maildir
  #     # maildir.path = "gmail";
  #
  #     # imap = {
  #     #   host = "imap.gmail.com";
  #     #   port = 993;
  #     # };
  #
  #     # smtp = {
  #     #   host = "smtp.gmail.com";
  #     #   # port = 587;
  #     # };
  #
  #     neomutt.enable = true;
  #     msmtp.enable = true;
  #     passwordCommand = "pass show gmail/owen.rodway"; # or your secret manager
  #   };
  # };

  # User specific packages
  home.packages = with pkgs; [
    arduino-ide
    bluetui
    cava
    cbonsai
    cook-cli
    discordo
    dwarf-fortress
    # element-desktop
    freecad
    minigalaxy
    # helix
    iamb
    impala
    irssi
    # kmonad
    libqalculate
    libsecret
    # mapscii
    obsidian
    openscad
    processing
    python3
    prismlauncher
    protonvpn-gui
    prusa-slicer
    # steamcmd
    # steam-tui
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
