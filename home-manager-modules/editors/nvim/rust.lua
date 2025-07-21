vim.g.rustaceanvim = {
	tools = {},
	server = {
		on_attach = function (client, bufnr)
			vim.keymap.set('n', 'K', function ()
				vim.cmd.RustLsp({ 'hover', 'actions' })
			end, { buffer = bufnr })
			vim.keymap.set('n', '<leader>ca', function ()
				vim.cmd.RustLsp('codeAction')
			end, { buffer = bufnr })
		end
	}
}
