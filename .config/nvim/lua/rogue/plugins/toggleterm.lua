return {
	"akinsho/toggleterm.nvim",
	keys = {
		{ "<C-`>", ":ToggleTerm<CR>", desc = "Toggle terminal float" },
	},
	opts = {
		open_mapping = [[<c-`>]],
		start_in_insert = true,
		shade_filetypes = { "neo-tree" },
		direction = "float",
		float_opts = {
			-- border = "curved",
		},
	},
	config = function(_, opts)
		require("toggleterm").setup(opts)
	end,
}
