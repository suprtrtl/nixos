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
          config = toLuaFile ./nvim/lsp/lsp.lua;
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
          config = toLuaFile ./nvim/lsp/cmp.lua;
        }

        {
          plugin = telescope-nvim;
          config = toLuaFile ./nvim/plugins/telescope.lua;
        }

        telescope-fzf-native-nvim

        cmp_luasnip
        cmp-nvim-lsp

        luasnip
        friendly-snippets

        {
          plugin = neo-tree-nvim;
          config = toLuaFile ./nvim/plugins/neo-tree.lua;
        }

        {
          plugin = lualine-nvim;
          config = toLuaFile ./nvim/plugins/lualine.lua;
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
            p.tree-sitter-regex
            p.tree-sitter-markdown
            p.tree-sitter-markdown_inline
          ]);
          config = toLuaFile ./nvim/plugins/treesitter.lua;
        }

        vim-nix

        vim-be-good

        {
          plugin = alpha-nvim;
          config = toLuaFile ./nvim/plugins/alpha.lua;
        }

        {
          plugin = rustaceanvim;
          config = toLuaFile ./nvim/lsp/langs/rust.lua;
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

        {
          plugin = noice-nvim;
          config = toLuaFile ./nvim/plugins/noice.lua;
        }
        {
          plugin = nvim-notify;
          config = toLua ''
            require('notify').setup {
              render = "compact",
            }
          '';
        }

        # Comment Out Lines to disable Copilot  -------
        # {
        #   plugin = copilot-lua;
        #   config = toLuaFile ./nvim/plugins/copilot.lua;
        # }
        # copilot-lualine
        # copilot-cmp 
        # --------------------------------------------
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
      copilot-language-server

      alejandra

      ripgrep
    ];

    nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];
  };
}
