return {
	"Shatur/neovim-session-manager",
	-- enabled = false,
	dependencies = "nvim-lua/plenary.nvim",
	config = function()
		require("session_manager").setup({
			autoload_mode = "Disabled",
			autosave_last_session = true,
			autosave_ignore_not_normal = true,
			autosave_ignore_dirs = {},
			autosave_ignore_filetypes = {
				"gitcommit",
				"gitrebase",
			},
			autosave_ignore_buftypes = {},
			autosave_only_in_session = false,
			max_path_length = 80,
		})
	end,
}
