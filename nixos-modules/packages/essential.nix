{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    alejandra
    curl
    fastfetch
    fzf
    git
    git-credential-manager
    libnotify
    neovim
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
  ];
}
