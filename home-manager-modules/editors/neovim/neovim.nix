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
    programs.neovim = let
      toLua = str: "lua << EOF\n${str}\nEOF\n";
      toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
    in {
      enable = true;

      # Redirects vi, vim and vimdiff binaries to nvim
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
    };

    home.packages = with pkgs; [
      wl-clipboard

      lua-language-server
      luajitPackages.lua-lsp
      nixd
      bash-language-server
      typescript-language-server
      vscode-langservers-extracted
      copilot-language-server

      alejandra

      ripgrep
    ];

    xdg.configFile."nvim".source = ".";

    nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];
  };
}
