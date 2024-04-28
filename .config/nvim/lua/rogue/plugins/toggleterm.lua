return {
	"akinsho/toggleterm.nvim",
	keys = {
		{ "<C-`>", ":ToggleTerm<CR>", desc = "Toggle terminal float" },
	},
	config = function()
		require("toggleterm").setup({
			open_mapping = [[<c-`>]],
			start_in_insert = true,
			shade_filetypes = { "neo-tree" },
			direction = "float",
			float_opts = {},
		})
	end,
}
