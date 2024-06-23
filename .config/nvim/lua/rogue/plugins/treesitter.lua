return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local configs = require("nvim-treesitter.configs")
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
			modules = {},
			ignore_install = { "javascript" },
			sync_install = true,
			parser_install_dir = nil,
			auto_install = true,
			highlight = {
				enable = true,
				-- disable = {},
			},

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
