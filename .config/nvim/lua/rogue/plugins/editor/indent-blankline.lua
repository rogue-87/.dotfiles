return {
	"lukas-reineke/indent-blankline.nvim",
	event = { "BufReadPre", "BufNewFile" },
	main = "ibl",
	opts = {
		--[[ indent = {
			char = "|",
			tab_char = "|",
		}, ]]
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
