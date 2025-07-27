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
    nixpkgs = {
      overlays = [
        (final: prev: {
          vimPlugins =
            prev.vimPlugins
            // {
              nvim-lsp-endhints = prev.vimUtils.buildVimPlugin {
                name = "nvim-lsp-endhints";
                src = inputs.plugin-nvim-lsp-endhints;
              };
            };
        })
      ];
    };

    programs.neovim = let
      toLua = str: "lua << EOF\n${str}\nEOF\n";
      toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
    in {
      enable = true;

      # Redirects vi, vim and vimdiff binaries to nvim
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;

      plugins = with pkgs.vimPlugins; [
        {
          plugin = nvim-lspconfig;
          config = toLuaFile ./nvim/lsp.lua;
        }

        {
          plugin = comment-nvim;
          config = toLua "require(\"Comment\").setup()";
        }

        {
          plugin = onedark-nvim;
          config = toLua ''
            require('onedark').setup {
              style = "dark"
            }

            require('onedark').load()
          '';
        }

        neodev-nvim

        nvim-cmp
        {
          plugin = nvim-cmp;
          config = toLuaFile ./nvim/cmp.lua;
        }

        {
          plugin = telescope-nvim;
          config = toLuaFile ./nvim/telescope.lua;
        }

        telescope-fzf-native-nvim

        cmp_luasnip
        cmp-nvim-lsp

        luasnip
        friendly-snippets

        {
          plugin = neo-tree-nvim;
          config = toLuaFile ./nvim/neo-tree.lua;
        }

        {
          plugin = lualine-nvim;
          config = toLua ''
            require("lualine").setup({
              icons_enabled = true,
              theme = 'onedark',
            })
          '';
        }
        nvim-web-devicons

        {
          plugin = nvim-treesitter.withPlugins (p: [
            p.tree-sitter-nix
            p.tree-sitter-vim
            p.tree-sitter-bash
            p.tree-sitter-lua
            p.tree-sitter-python
            p.tree-sitter-json
            p.tree-sitter-rust
          ]);
          config = toLuaFile ./nvim/treesitter.lua;
        }

        vim-nix

        vim-be-good

        {
          plugin = alpha-nvim;
          config = toLuaFile ./nvim/alpha.lua;
        }

        {
          plugin = rustaceanvim;
          config = toLuaFile ./nvim/rust.lua;
        }
        {
          plugin = nvim-lsp-endhints;
          config = toLua ''
            require('lsp-endhints').setup {
              label = { truncateAtChars = 35, padding = 2 }
            }
          '';
        }

        undotree
      ];

      extraLuaConfig = ''
        ${builtins.readFile ./nvim/remap.lua}

        ${builtins.readFile ./nvim/options.lua}
      '';
    };

    home.packages = with pkgs; [
      wl-clipboard

      lua-language-server
      luajitPackages.lua-lsp
      nixd
      bash-language-server
      typescript-language-server
      vscode-langservers-extracted
      
      alejandra

      ripgrep

    ];

    nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];
  };
}
