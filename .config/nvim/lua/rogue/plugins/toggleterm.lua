---@diagnostic disable: lowercase-global
return {
	"akinsho/toggleterm.nvim",
	event = { "VeryLazy" },
	keys = {
		{ "<C-`>", ":ToggleTerm<CR>", desc = "Toggle terminal float" },
	},
	config = function()
		local toggleterm = require("toggleterm")
		local Terminal = require("toggleterm.terminal").Terminal

		toggleterm.setup({
			open_mapping = [[<c-`>]],
			start_in_insert = true,
			shade_filetypes = { "neo-tree" },
			direction = "float",
			float_opts = {
                border = "single"
            },
		})

		-- extra stuff
		local lazygit = Terminal:new({
			cmd = "lazygit",
			dir = "git_dir",
			direction = "float",
			float_opts = {
				border = "single",
				width = 180,
				height = 40,
			},
			on_open = function(term)
				vim.cmd("startinsert!")
				vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
			end,
			on_close = function(term)
				vim.cmd("startinsert!")
			end,
		})
		function _lazygit_toggle()
			lazygit:toggle()
		end

		local glow = Terminal:new({
			cmd = "glow",
			direction = "float",
			float_opts = {
				border = "single",
				width = 180,
				height = 38,
			},
			on_open = function(term)
				vim.cmd("startinsert!")
				vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
			end,
			on_close = function(term)
				vim.cmd("startinsert!")
			end,
		})
		function _glow_toggle()
			glow:toggle()
		end

		vim.api.nvim_set_keymap(
			"n",
			"<leader>tlg",
			"<cmd>lua _lazygit_toggle()<CR>",
			{ noremap = true, silent = true, desc = "Toggle Lazygit" }
		)
		vim.api.nvim_set_keymap(
			"n",
			"<leader>tg",
			"<cmd>lua _glow_toggle()<CR>",
			{ noremap = true, silent = true, desc = "Toggle Glow" }
		)
		-- end of extra stuff
	end,
}
