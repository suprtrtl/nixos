vim.g.truemapleader = ' '

local map = vim.keymap.set 

map({ 'n', 'v', 'x' }, '<leader>s', ':e #<CR>', { desc = "switch windows" })
map('n', '<bs>', ':e #<CR>', { desc = "switch windows" })

map('n', '<leader>ff', ':Pick files<CR>', { desc = "find files" })
map('n', '<leader>fg', ':Pick grep_live<CR>', { desc = "live grep" })
map('n', '<leader>fh', ':Pick help<CR>', { desc = "search help" })

map('n', '<leader>pv', ':Oil<CR>', { desc = "open oil" })
-- map('n', '<leader>e', require('oil').open_float(), { desc = "open oil" })
map('n', '-', ':Oil<CR>', { desc = "open oil" })

map('n', '<leader>cs', 'i<C-x>s', { desc = "check spelling" })

map('n', '<leader>mvt', ':Markview toggle<CR>', { desc = 'toggle' })
map('n', '<leader>mvs', ':Markview splitToggle<CR>', { desc = 'split toggle' })

-- -- Undotree
-- map('n', '<leader><F5>', vim.cmd.UndotreeToggle)
