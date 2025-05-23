require('neo-tree').setup({
	event_handlers = {
		{
			event = "file_open_requested",
			handler = function()
				require('neo-tree.command').execute({ action = "close" })
			end
		},
	},

	source_selector = {
		winbar = true
	}
})
