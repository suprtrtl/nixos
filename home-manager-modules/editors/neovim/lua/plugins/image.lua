if os.getenv("KITTY_IMAGE_PROTOCOL") == '1' then
	return {
		"3rd/image.nvim",
		build = false,
		opts = {
			processor = "magick_cli",
		},
	}
else
	return {}
end
