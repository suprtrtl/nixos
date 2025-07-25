local on_attach = function(_, bufnr)
	local bufmap = function(keys, func)
		vim.keymap.set('n', keys, func, { buffer = bufnr })
	end

	bufmap('<leader>ca', vim.lsp.buf.code_action)
	bufmap('<leader>rn', vim.lsp.buf.rename)

	bufmap('gd', vim.lsp.buf.definition)
	bufmap('gD', vim.lsp.buf.declaration)
	bufmap('gI', vim.lsp.buf.implementation)
	bufmap('<leader>D', vim.lsp.buf.type_definition)

	bufmap('gr', require('telescope.builtin').lsp_references)
	bufmap('<leader>s', require('telescope.builtin').lsp_document_symbols)
	bufmap('<leader>S', require('telescope.builtin').lsp_dynamic_workspace_symbols)

	bufmap('K', vim.lsp.buf.hover)

	bufmap('<leader>fmt', vim.lsp.buf.format)
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
	cmd = { "lua-language-server" },
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
	cmd = { 'nixd' },
	settings = {
		nixd = {
			nixpkgs = {
				expr = 'import <nixpkgs> { }',
			},
			formatting = {
				command = { "alejandra" },
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

-- require('lspconfig').rust_analyzer.setup {
-- 	on_attach = on_attach,
-- 	capabilities = capabilities,
-- 	settings = {
-- 		["rust-analyzer"] = {
-- 			cargo = {
-- 				loadOutDirsFromCheck = true,
-- 				runBuildScripts = true,
-- 				features = "all",
-- 			},
-- 			procMacro = {
-- 				enable = true,
-- 			},
-- 			checkOnSave = {
-- 				command = "check"
-- 			}
-- 		}
-- 	}
-- }

require('lspconfig').ts_ls.setup {
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
}

-- Rustaceanvim setup

local bufnr = vim.api.nvim_get_current_buf()
vim.keymap.set(
	'n',
	'<leader>ca',
	function()
		vim.cmd.RustLsp('codeAction')
	end,
	{ buffer = bufnr }
)
vim.keymap.set(
	'n',
	'K',
	function()
		vim.cmd.RustLsp({ 'hover', 'actions' })
	end,
	{ buffer = bufnr }
)
