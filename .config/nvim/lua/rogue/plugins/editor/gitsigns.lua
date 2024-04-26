return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("gitsigns").setup()
		local gs = package.loaded.gitsigns
		local map = vim.keymap.set

		map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview hunk" })

		map("n", "<leader>hb", function()
			gs.blame_line({ full = true })
		end, { desc = "Blame line" })

		map("n", "<leader>hB", gs.toggle_current_line_blame, { desc = "Toggle line blame" })

		map("n", "<leader>hd", gs.diffthis, { desc = "Diff this" })

		map("n", "<leader>hD", function()
			gs.diffthis("~")
		end, { desc = "Diff this ~" })
	end,
}
