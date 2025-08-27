{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  options = {
    neovim.enable =
      lib.mkEnableOption "enable neovim";
  };

  config = lib.mkIf config.neovim.enable {
    programs.neovim = {
      enable = true;

      # Redirects vi, vim and vimdiff binaries to nvim
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
    };

    home.packages = with pkgs; [
      wl-clipboard
      zig
      tree-sitter
      ueberzugpp
      imagemagick

      nodejs_20

      lua-language-server
      luajitPackages.lua-lsp
      nixd
      bash-language-server
      typescript-language-server
      vscode-langservers-extracted
      hyprls

      alejandra

      ripgrep
    ];

    xdg.configFile."nvim".source = inputs.nvim-src;

    home.sessionVariables = {
      NIX_NEOVIM = 1;
      KITTY_IMAGE_PROTOCOL = 1;
    };
  };
}
