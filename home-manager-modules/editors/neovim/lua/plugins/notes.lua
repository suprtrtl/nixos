local obsidian_vaults = {
	{
		name = "personal",
		path = "~/notes/personal",
	},

	{
		name = "project-zero",
		path = "~/notes/worldbuilding/project-zero"
	}

}


return {

	-- Markdown

	-- Markview config in `treesitter.lua`
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = "cd app && yarn install",
		config = function()
			vim.g.mkdp_markdown_css = vim.fn.expand('~/.config/markdown-style/markdown.css')
			vim.g.mkdp_highlight_css = vim.fn.expand('~/.config/markdown-style/highlight.css')
		end
	},

	{
		"epwalsh/obsidian.nvim",
		version = "*", -- recommended, use latest release instead of latest commit
		lazy = true,
		ft = "markdown",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"hisbaan/dataview.nvim",
				opts = {
					vault_dir = function()
						local dirs = {}
						for _, value in pairs(obsidian_vaults) do
							table.insert(dirs, value.path)
						end
						return dirs
					end,
				}
			},
		},
		opts = {
			workspaces = obsidian_vaults,
		},
	},


	{
		"jghauser/follow-md-links.nvim",
		ft = "markdown",
	},

	-- Typst
	{
		'chomosuke/typst-preview.nvim',
		ft = 'typst',
		version = '1.*',
		opts = {}, -- lazy.nvim will implicitly calls `setup {}`
	},

}
