{
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [
    ./cli/fzf.nix
    ./cli/git.nix
    ./cli/tmux.nix
    ./cli/zoxide.nix

    ./editors/neovim.nix

    ./shells/zsh.nix

    ./terminals/ghostty.nix
    ./terminals/alacritty.nix

    ./tui/btop.nix
  ];
}
