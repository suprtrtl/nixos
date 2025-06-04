{
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [
    ./cli/fzf.nix
    ./cli/git.nix
    ./cli/zoxide.nix

    ./editors/neovim.nix
    ./editors/emacs.nix

    ./shells/zsh.nix
    ./shells/prompts/oh-my-posh.nix

    ./terminals/ghostty.nix
    ./terminals/alacritty.nix

    ./tui/btop.nix
    ./tui/lazygit.nix
    ./tui/music/rmpc.nix
    ./tui/terminal-multiplexers/tmux.nix
    ./tui/terminal-multiplexers/zellij.nix
  ];
}
