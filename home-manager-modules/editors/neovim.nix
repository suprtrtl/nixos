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
      package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;

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
      rustc

      nodejs_20

      lua-language-server
      luajitPackages.lua-lsp
      nixd
      bash-language-server
      typescript-language-server
      vscode-langservers-extracted
      hyprls
      rust-analyzer
      jdt-language-server
      vscode-extensions.vscjava.vscode-java-test
      vscode-extensions.vscjava.vscode-java-debug
      python3Packages.jedi-language-server
      python3Packages.python-lsp-server
      python3Packages.rope
      python3Packages.pylsp-rope
      python3Packages.pylint
      python3Packages.pylint-venv
      python3Packages.flake8
      python3Packages.yapf

      openjdk17

      alejandra

      ripgrep
    ];

    xdg.configFile."nvim".source = inputs.nvim-config-src;

    home.sessionVariables = {
      NIX_NEOVIM = 1;
      KITTY_IMAGE_PROTOCOL = 1;
    };
  };
}
