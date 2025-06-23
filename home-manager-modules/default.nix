{
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [
    ./styles.nix

    ./cli/fzf.nix
    ./cli/git.nix
    ./cli/zoxide.nix

    ./editors/neovim.nix
    ./editors/emacs.nix

    ./gui/notes/obsidian.nix

    ./shells/zsh.nix
    ./shells/fish.nix

    ./shells/prompts/oh-my-posh.nix

    ./terminals/ghostty.nix
    ./terminals/alacritty.nix

    ./tui/btop.nix
    ./tui/lazygit.nix

    ./tui/files/yazi.nix
    ./tui/music/rmpc.nix

    ./tui/terminal-multiplexers/tmux.nix
    ./tui/terminal-multiplexers/zellij.nix
  ];
}
