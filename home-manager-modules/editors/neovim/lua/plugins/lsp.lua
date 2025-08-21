return {
	'neovim/nvim-lspconfig',
	dependencies = {
		'hrsh7th/cmp-nvim-lsp',
		'hrsh7th/nvim-cmp',	
        'saadparwaiz1/cmp_luasnip',
        'L3MON4D3/LuaSnip',
	},

	config = function ()
local on_attach = function(_, bufnr)
	local bufmap = function(keys, func, desc)
		desc = desc or 'todo'
		vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
	end

	bufmap('<leader>ca', vim.lsp.buf.code_action, 'code action')
	bufmap('<leader>rn', vim.lsp.buf.rename, 'rename')

	bufmap('gd', vim.lsp.buf.definition, 'definition')
	bufmap('gD', vim.lsp.buf.declaration, 'declaration')
	bufmap('gI', vim.lsp.buf.implementation, 'implementation')
	bufmap('<leader>D', vim.lsp.buf.type_definition, 'type definition')

	bufmap('gr', ':Pick lsp scope="references"<CR>', 'lsp references')
	bufmap('<leader>ls', ':Pick lsp scope="document_symbol"<CR>', 'lsp symbols')
	bufmap('<leader>lS', ':Pick lsp scope="workspace_symbol"<CR>', 'workspace symbols')

	bufmap('<leader>K', vim.diagnostic.open_float, 'diagnostics')
	bufmap('<leader>fd', ':Pick diagnostic<CR>', 'find diagnostics')

	bufmap('K', vim.lsp.buf.hover, 'hover')

	bufmap('<leader>fmt', vim.lsp.buf.format, 'format')
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- require('neodev').setup()
require('lspconfig').lua_ls.setup {
	on_attach = on_attach,
	capabilities = capabilities,
	root_dir = function()
		return vim.loop.cwd()
	end,
	cmd = { 'lua-language-server' },
	settings = {
		Lua = {
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
			hint = { enable = true },
		},
	}
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
-- 		['rust-analyzer'] = {
-- 			cargo = {
-- 				loadOutDirsFromCheck = true,
-- 				runBuildScripts = true,
-- 				features = 'all',
-- 			},
-- 			procMacro = {
-- 				enable = true,
-- 			},
-- 			checkOnSave = {
-- 				command = 'check'
-- 			}
-- 		}
-- 	}
-- }

local inlayHints = {
	includeInlayParameterNameHints = 'all',
	includeInlayParameterNameHintsWhenArgumentMatchesName = false,
	includeInlayFunctionParameterTypeHints = true,
	includeInlayVariableTypeHints = true,
	includeInlayVariableTypeHintsWhenTypeMatchesName = false,
	includeInlayPropertyDeclarationTypeHints = true,
	includeInlayFunctionLikeReturnTypeHints = true,
	includeInlayEnumMemberValueHints = true,
}

require('lspconfig').ts_ls.setup {
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
	settings = {
		typescript = {
			inlayHints = inlayHints,
		},
		javascript = {
			inlayHints = inlayHints,
		},
	}
}

require('lspconfig').html.setup{
	on_attach = on_attach,
	capabilities = capabilities,
}
require('lspconfig').cssls.setup{}
    end
}
