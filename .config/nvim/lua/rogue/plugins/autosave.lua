return {
	"0x00-ketsu/autosave.nvim",
	-- lazy-loading on events
	event = { "InsertLeave", "TextChanged" },
	config = function()
		require("autosave").setup({
			enable = false,
         prompt_style = "stdout",
			prompt_message = function()
				return "Autosave: saved at " .. vim.fn.strftime("%H:%M:%S")
			end,
			events = { "InsertLeave", "TextChanged" },
			conditions = {
				exists = true,
				modifiable = true,
				filename_is_not = {},
				filetype_is_not = {},
			},
			write_all_buffers = false,
			debounce_delay = 135,
		})
	end,
}
