return {
	"nvim-neo-tree/neo-tree.nvim",
	keys = {
		{ "<leader>ft", "<cmd>Neotree toggle<CR>", desc = "Toggle Neotree" },
		{ "<leader>\\", "<cmd>Neotree reveal<cr>", desc = "Reveal file location in Neotree" },
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-tree/nvim-web-devicons",
		-- "3rd/image.nvim",
		{
			"s1n7ax/nvim-window-picker",
			name = "window-picker",
			version = "2.*",
			config = function()
				require("window-picker").setup({
					filter_rules = {
						include_current_win = false,
						autoselect_one = true,
						bo = {
							filetype = { "neo-tree", "neo-tree-popup", "notify" },
							buftype = { "terminal" },
						},
					},
				})
			end,
		},
	},
	init = function()
		vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
		vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
		vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
		vim.fn.sign_define("DiagnosticSignHint", { text = "󰌵", texthl = "DiagnosticSignHint" })
	end,
	opts = {
		window = {
			position = "left",
		},
		default_component_configs = {
			git_status = {
				symbols = {
					-- Change type
					added = "", -- ✚
					modified = "", -- 
					deleted = "✖",
					renamed = "󰁕",
					-- Status type
					untracked = "",
					ignored = "",
					unstaged = "",
					staged = "",
					conflict = "",
				},
			},
		},
	},
}
