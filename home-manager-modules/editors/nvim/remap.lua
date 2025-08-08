

vim.g.mapleader = ' '

vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>s', ':e #<CR>')
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>S', ':sf #<CR>')


-- Telescope Keymaps
local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>ff', builtin.find_files)
vim.keymap.set('n', '<leader>FF', builtin.git_files)
vim.keymap.set('n', '<leader>fg', builtin.live_grep)

-- Neotree Keymaps
vim.keymap.set('n', '<leader>n', ':Neotree filesystem focus toggle left<CR>')
vim.keymap.set('n', '<leader>gs', ':Neotree git_status focus toggle float<CR>')
vim.keymap.set('n', '<leader>N', ':Neotree buffers focus toggle left<CR>')

-- Undotree
vim.keymap.set('n', '<leader><F5>', vim.cmd.UndotreeToggle)
