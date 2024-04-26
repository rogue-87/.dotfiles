return {
	"nanozuki/tabby.nvim",
  -- enabled = false,
	event = { "VimEnter" },
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		require("tabby.tabline").use_preset("active_wins_at_tail", {})

		local theme = {
			fill = "TabLineFill",
			head = "TabLine",
			current_tab = "TabLineSel",
			tab = "TabLine",
			win = "TabLine",
			tail = "TabLine",
		}
		require("tabby.tabline").set(function(line)
			return {
				{
					{ "  ", hl = theme.head },
					line.sep("", theme.head, theme.fill),
				},
				line.tabs().foreach(function(tab)
					local hl = tab.is_current() and theme.current_tab or theme.tab
					return {
						line.sep("", hl, theme.fill),
						-- tab.is_current() and "" or "",
						tab.number(),
						tab.name(),
						tab.close_btn(""),
						line.sep("", hl, theme.fill),
						hl = hl,
						margin = " ",
					}
				end),
				line.spacer(),
				line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
					return {
						line.sep("", theme.win, theme.fill),
						win.is_current() and "" or "󰆣",
						win.buf_name(),
						line.sep("", theme.win, theme.fill),
						hl = theme.win,
						margin = " ",
					}
				end),
				{
					line.sep("", theme.tail, theme.fill),
					{ "  ", hl = theme.tail },
				},
				hl = theme.fill,
			}
		end)

		local map = vim.keymap.set
		local opts = { noremap = true, silent = true }
		map("n", "<A-n>", ":$tabnew<CR>", opts)
		map("n", "<A-c>", ":tabclose<CR>", opts)
		map("n", "<A-t>", ":tabonly<CR>", opts)
		map("n", "<A-.>", ":tabn<CR>", opts)
		map("n", "<A-,>", ":tabp<CR>", opts)
		map("n", "<C-,>", ":-tabmove<CR>", opts)
		map("n", "<C-.>", ":+tabmove<CR>", opts)
	end,
}
