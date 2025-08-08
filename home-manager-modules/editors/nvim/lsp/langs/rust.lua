vim.g.rustaceanvim = {
	tools = {},
	server = {
		on_attach = function(client, bufnr)
			local bufmap = function(keys, func)
				vim.keymap.set('n', keys, func, { buffer = bufnr })
			end

			bufmap('<leader>rn', vim.lsp.buf.rename)

			bufmap('gd', vim.lsp.buf.definition)
			bufmap('gD', vim.lsp.buf.declaration)
			bufmap('gI', vim.lsp.buf.implementation)
			bufmap('<leader>D', vim.lsp.buf.type_definition)

			bufmap('gr', require('telescope.builtin').lsp_references)
			bufmap('<leader>ls', require('telescope.builtin').lsp_document_symbols)
			bufmap('<leader>lS', require('telescope.builtin').lsp_dynamic_workspace_symbols)

			bufmap('<leader>K', vim.diagnostic.open_float)
			bufmap('<leader>fd', function()
				vim.cmd.Telescope('diagnostics')
			end)

			bufmap('<leader>fmt', vim.lsp.buf.format)

			bufmap('K', function()
				vim.cmd.RustLsp({ 'hover', 'actions' })
			end)
			bufmap('<leader>ca', function()
				vim.cmd.RustLsp('codeAction')
			end)

			bufmap('<leader>ih', function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
			end)
		end
	}
}
