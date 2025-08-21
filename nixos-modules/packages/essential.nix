{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    alejandra
    bat
    curl
    fastfetch
    fd
    flameshot
    fzf
    git
    git-credential-manager
    libnotify
    pavucontrol
    neovim
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
  ];
}
