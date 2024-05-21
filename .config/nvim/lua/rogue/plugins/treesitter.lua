return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local configs = require("nvim-treesitter.configs")
		---@diagnostic disable-next-line: missing-fields
		configs.setup({
			ensure_installed = {
				"c",
				"lua",
				"vim",
				"vimdoc",
				"regex",
				"query",

				"html",
				"css",
				"scss",
				"javascript",
				"vue",
				"markdown",
				"json",

				"python",
				"bash",
        "go",

				-- in order for some plugins to work properly
				"jsonc",
				"markdown_inline",
			},
			auto_install = true,
			highlight = { enable = true },

			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<leader>ss",
					node_incremental = "<leader>si",
					scope_incremental = "<leader>sc",
					node_decremental = "<leader>sd",
				},
			},
		})
	end,
}
