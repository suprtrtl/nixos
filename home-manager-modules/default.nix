{
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [
    ./styles.nix
    ./robotics.nix

    ./cli/cheat.nix
    ./cli/fzf.nix
    ./cli/git.nix
    ./cli/rofi/rofi.nix
    ./cli/tofi/tofi.nix
    ./cli/zoxide.nix

    ./cli/misc.nix

    ./editors/neovim.nix
    ./editors/vscode.nix
    ./editors/emacs/emacs.nix

    ./gui/vlc.nix
    ./gui/lutris.nix
    ./gui/browsers/nyxt.nix
    ./gui/browsers/qute.nix
    ./gui/dev/godot.nix

    ./hyprland/hyprland.nix
    ./niri/niri.nix

    # ./quickshell/quickshell.nix

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
