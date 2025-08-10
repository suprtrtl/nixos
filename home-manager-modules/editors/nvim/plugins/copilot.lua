require('copilot').setup {}
require('copilot_cmp').setup {}

local bufmap = function (keys, func)
	vim.keymap.set('n', keys, function ()
		func
	end, { buffer = true })
end

local panel = require('copilot.panel')
vim.keymap.set('n', '<leader>cpo', function ()
	panel.open({ position = "bottom", ratio = 0.4 })
end, {})

vim.keymap.set('n', '<leader>cpt', function ()
	panel.toggle()
end, {})

bufmap('<leader>cpa', panel.accept());
bufmap('<leader>cpn', panel.jump_next());
bufmap('<leader>cpN', panel.jump_prev());
bufmap('<leader>cpr', panel.refresh());
