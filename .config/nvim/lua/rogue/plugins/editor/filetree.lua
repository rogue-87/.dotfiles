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
	config = function()
		require("neo-tree").setup({
			close_if_last_window = false,
			sort_case_insensitive = false,
			--[[ sort_function = function(a, b)
				if a.type == b.type then
					return a.path > b.path
				else
					return a.type > b.type
				end
			end, ]]
			filesystem = {
				filtered_items = {
					visible = true,
					hide_dotfiles = true,
					hide_gitignored = true,
					hide_by_name = {},
				},
				window = {
					mappings = {
						["O"] = "system_open",
					},
				},
			},
			window = {
				position = "left",
				width = 40,
			},
			source_selector = {
				winbar = true,
				statusline = false,
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
			event_handlers = {
				{
					event = "file_opened",
					handler = function(file_path)
						require("neo-tree.command").execute({ action = "close" })
					end,
				},
			},
			commands = {
				system_open = function(state)
					local node = state.tree:get_node()
					local path = node:get_id()
					-- macOs: open file in default application in the background.
					vim.fn.jobstart({ "xdg-open", "-g", path }, { detach = true })
					-- Linux: open file in default application
					vim.fn.jobstart({ "xdg-open", path }, { detach = true })

					-- Windows: Without removing the file from the path, it opens in code.exe instead of explorer.exe
					local p
					local lastSlashIndex = path:match("^.+()\\[^\\]*$") -- Match the last slash and everything before it
					if lastSlashIndex then
						p = path:sub(1, lastSlashIndex - 1) -- Extract substring before the last slash
					else
						p = path -- If no slash found, return original path
					end
					vim.cmd("silent !start explorer " .. p)
				end,
			},
		})
	end,
}
