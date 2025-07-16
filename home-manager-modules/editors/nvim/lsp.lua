local on_attach = function(_, bufnr)

	local bufmap = function(keys, func)
		vim.keymap.set('n', keys, func, { buffer = bufnr })
	end

	bufmap('<leader>rn', vim.lsp.buf.rename)
	bufmap('<leader>ca', vim.lsp.buf.code_action)

	bufmap('gd', vim.lsp.buf.definition)
	bufmap('gD', vim.lsp.buf.declaration)
	bufmap('gI', vim.lsp.buf.implementation)
	bufmap('<leader>D', vim.lsp.buf.type_definition)

	bufmap('gr', require('telescope.builtin').lsp_references)
	bufmap('<leader>s', require('telescope.builtin').lsp_document_symbols)
	bufmap('<leader>S', require('telescope.builtin').lsp_dynamic_workspace_symbols)

	bufmap('K', vim.lsp.buf.hover)

	vim.api.nvim_buf_create_user_command(bufnr,'Format', function(_)
		vim.lsp.buf.format({ async = true }, function(err)
			if err then
				vim.notify('Format error: ' .. err.message, vim.log.levels.ERROR)
			end
		end)
	end, {})
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

require('neodev').setup()
require('lspconfig').lua_ls.setup {
	on_attach = on_attach,
	capabilities = capabilities,
	root_dir = function()
		return vim.loop.cwd()
	end,
	cmd = {"lua-language-server"},
	settings = {
		Lua = {
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
		},
	}
}

require('lspconfig').nixd.setup {
	on_attach = on_attach,
	capabilities = capabilities,
	cmd = {'nixd'},
	settings = {
		nixd = {
			nixpkgs = {
				expr = 'import <nixpkgs> { }',
			},
			formatting = {
				command = {"alejandra"},
			},
			formattingProvider = true,
		},
	},
}

require('lspconfig').bashls.setup {
	on_attach = on_attach,
	capabilities = capabilities,
	cmd = { 'bash-language-server', 'start' },
	filetypes = { 'bash', 'sh' },
}

require('lspconfig').rust_analyzer.setup {
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		["rust-analyzer"] = {
			cargo = {
				loadOutDirsFromCheck = true,
				runBuildScripts = true,
				features = "all",
			},
			procMacro = {
				enable = true,
			},
			checkOnSave = {
				command = "check"
			}
		}
	}
}


