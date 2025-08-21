vim.api.nvim_create_autocmd("Filetype", {
	pattern = { "markdown", "txt", "env" },
	callback = function(opts)
		vim.defer_fn(function()
			vim.cmd.colorscheme("onedark")
		end, 50)
		vim.o.spelllang = "en_ca"
		vim.o.spell = true
	end
})
