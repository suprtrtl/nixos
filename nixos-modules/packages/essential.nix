{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    p7zip
    alejandra
    bat
    brightnessctl
    cargo
    cheat
    curl
    efibootmgr
    efibooteditor
    fastfetch
    fd
    ffmpeg
    flameshot
    fzf
    gcc
    git
    git-credential-manager
    gparted
    gnumake
    libnotify
    pavucontrol
    rar
    rustc
    neovim
    networkmanager
    nix-search-cli
    tldr
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    unzip
    wget
  ];

  documentation.man.generateCaches = true;
}
