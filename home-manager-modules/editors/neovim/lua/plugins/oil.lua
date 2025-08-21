return {
	'stevearc/oil.nvim',
	---@module 'oil'
	---@type oil.SetupOpts
	opts = {
		columns = {
			"size",
			"icon",
			-- "permissions",
			-- "mtime",
		},

		view_options = {
			show_hidden = true,
		},

		skip_confirm_for_simple_edits = false,

	},
	-- Optional dependencies
	dependencies = { { "echasnovski/mini.icons", opts = {} } },
	lazy = false,
}
