return {
	"otavioschwanck/arrow.nvim",
	keys = {
		{ "<C-s>", "<cmd>Arrow open<cr>" },
	},
	opts = {
		save_path = function()
			return vim.fn.stdpath("cache") .. "/arrow"
		end,
		show_icons = true,
		leader_key = " ", -- Recommended to be a single key
		window = {
			border = "none",
		},
	},
}
