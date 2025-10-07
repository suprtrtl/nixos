{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    alejandra
    bat
    cargo
    cheat
    curl
    efibootmgr
    efibooteditor
    fastfetch
    fd
    flameshot
    fzf
    gcc
    git
    git-credential-manager
    libnotify
    pavucontrol
    rustc
    neovim
    networkmanager
    tldr
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    unzip
    wget
  ];

  documentation.man.generateCaches = true;
}
