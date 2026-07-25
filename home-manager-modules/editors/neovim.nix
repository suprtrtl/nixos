{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: let
  localPath = "${config.home.homeDirectory}/neovim";
in {
  options = {
    neovim.enable =
      lib.mkEnableOption "enable neovim";
  };

  config = lib.mkIf config.neovim.enable {
    programs.neovim = {
      enable = true;
      package = inputs.neovim-nightly-overlay.packages.${pkgs.stdenv.hostPlatform.system}.default;

      # Redirects vi, vim and vimdiff binaries to nvim
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;

      plugins = with pkgs.vimPlugins; [
        nvim-treesitter.withAllGrammars
      ];
    };

    home.packages = with pkgs; [
      wl-clipboard
      tree-sitter
      ueberzugpp
      imagemagick
      rustc

      # pkgs.zigpkgs.master

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
      clang
      zls
      gopls

      jdk25

      alejandra

      ripgrep

      yarn
    ];

    xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink localPath;
    xdg.configFile."nvim/init.lua".enable = lib.mkForce false;

    home.sessionVariables = {
      NIX_NEOVIM = 1;
      KITTY_IMAGE_PROTOCOL = 1;
    };
  };
}
