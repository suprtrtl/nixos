return {
	'echasnovski/mini.nvim',
	config = function()
		require('mini.ai').setup()
		require('mini.pick').setup()
		require('mini.notify').setup()
		require('mini.extra').setup()
		require('mini.surround').setup()
		require('mini.clue').setup {
			triggers = {
				{ mode = 'n', keys = '<leader>' },
				{ mode = 'n', keys = 'g' },
				{ mode = 'n', keys = 'z' },
				{ mode = 'n', keys = '<C-w>' },
				{ mode = 'i', keys = '<C-x>' },
				{ mode = 'c', keys = '<C-r>' },
			},

			clues = {
				{ mode = 'n', keys = '<leader>f', desc = "find" },
				{ mode = 'n', keys = '<leader>m', desc = "notes" },
				{ mode = 'n', keys = '<leader>mv', desc = "markview" },

				require('mini.clue').gen_clues.g(),
				require('mini.clue').gen_clues.z(),
				require('mini.clue').gen_clues.windows({ submode_resize = true }),
				require('mini.clue').gen_clues.builtin_completion(),
				require('mini.clue').gen_clues.registers(),
			},

			window = {
				delay = 100,
				config = {
					width = 'auto'
				}
			}

		}
		require('mini.git').setup()
	end
}
