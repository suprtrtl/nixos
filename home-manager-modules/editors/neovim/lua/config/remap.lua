vim.g.truemapleader = ' '

local map = vim.keymap.set 

map({ 'n', 'v', 'x' }, '<leader>s', ':e #<CR>', { desc = "switch windows" })
map('n', '<bs>', ':e #<CR>', { desc = "switch windows" })

map('n', '<leader>ff', ':Pick files<CR>', { desc = "find files" })
map('n', '<leader>fg', ':Pick grep_live<CR>', { desc = "live grep" })
map('n', '<leader>fh', ':Pick help<CR>', { desc = "search help" })

map('n', '<leader>pv', ':lua MiniFiles.open()<CR>', { desc = "open mini.files" })
map('n', '<leader>e', ':lua MiniFiles.open()<CR>', { desc = "open mini.files" })
map('n', '-', ':lua MiniFiles.open()<CR>', { desc = "open mini.files" })

map('n', '<leader>cs', ':Pick spellsuggest<CR>', { desc = "check spelling" })

map('n', '<leader>mvt', ':Markview toggle<CR>', { desc = 'toggle' })
map('n', '<leader>mvs', ':Markview splitToggle<CR>', { desc = 'split toggle' })

-- -- Undotree
map('n', '<leader><F5>', ':UndotreeToggle<CR>', { desc = 'undotree'})
