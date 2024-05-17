return {
	"lukas-reineke/indent-blankline.nvim",
  version = "3.5.4",
	event = { "BufReadPre", "BufNewFile" },
	main = "ibl",
	opts = {
		scope = { enabled = false },
		exclude = {
			filetypes = {
				"help",
				"alpha",
				"dashboard",
				"neo-tree",
				"lazy",
				"mason",
				"notify",
				"toggleterm",
			},
		},
	},
}
