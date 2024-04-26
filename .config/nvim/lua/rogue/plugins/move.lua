return {
	"fedepujol/move.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {},
	config = function()
		require("move").setup()
		local opts = { noremap = true, silent = true }
		local map = vim.keymap.set
		map("n", "<A-j>", ":MoveLine(1)<CR>", opts)
		map("n", "<A-k>", ":MoveLine(-1)<CR>", opts)
		map("v", "<A-j>", ":MoveBlock(1)<CR>", opts)
		map("v", "<A-k>", ":MoveBlock(-1)<CR>", opts)
	end,
}
