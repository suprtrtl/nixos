return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		"OXY2DEV/markview.nvim",
	},
	lazy = false,
	build = function()
		require("nvim-treesitter.install").update({ with_sync = true })()
	end,

	config = function()
		require 'nvim-treesitter.configs'.setup {
			-- A list of parser names, or "all" (the listed parsers MUST always be installed)
			ensure_installed = {
				"rust",
				"go",
				"c",
				"zig",
				"javascript",
				"typescript",
				"lua",
				"vim",
				"vimdoc",
				"query",
				"markdown",
				"markdown_inline",
				"latex",
				"typst",
			},

			-- Install parsers synchronously (only applied to `ensure_installed`)
			sync_install = false,

			-- Automatically install missing parsers when entering buffer
			-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
			auto_install = true,

			---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
			-- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

			highlight = {
				enable = true,
			},

		}

		local markview = require('markview')
		local presets = require('markview.presets')

		markview.setup {
			markdown = {
				headings = presets.headings.glow,
				horizontal_rules = presets.horizontal_rules.thin,
				tables = presets.tables.rounded,

				list_items = {
					shift_width = function(buffer, item)
						return 4;
					end
				}
			},

			modes = { "n", "c" },
			hybrid_modes = { "n" },

			callbacks = {
				on_enable = function(_, win)
					vim.wo[win].conceallevel = 2;
					-- This will prevent Tree-sitter concealment being disabled on the cmdline mode
					vim.wo[win].concealcursor = "c";
				end
			}

		}

		require("markview.extras.checkboxes").setup({
			--- Default checkbox state(used when adding checkboxes).
			---@type string
			default = "X",

			--- Changes how checkboxes are removed.
			---@type
			---| "disable" Disables the checkbox.
			---| "checkbox" Removes the checkbox.
			---| "list_item" Removes the list item markers too.
			remove_style = "disable",

			--- Various checkbox states.
			---
			--- States are in sets to quickly change between them
			--- when there are a lot of states.
			---@type string[][]
			states = {
				{ " ", "/", "X" },
				{ "<", ">" },
				{ "?", "!", "*" },
				{ '"' },
				{ "l", "b", "i" },
				{ "S", "I" },
				{ "p", "c" },
				{ "f", "k", "w" },
				{ "u", "d" }
			}
		})

		require("markview.extras.headings").setup();
		require("markview.extras.editor").setup();
	end,
}
