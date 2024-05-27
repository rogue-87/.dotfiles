return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")
		dashboard.section.header.val = {
			[[                               __                ]],
			[[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
			[[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
			[[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
			[[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
			[[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
		}
		dashboard.section.buttons.val = {
			dashboard.button("e", "  New file", ":ene <BAR> startinsert <cr>"),

			dashboard.button("s", "  Open last session", "<cmd>SessionManager load_last_session<cr>"),

			dashboard.button("f", "󰍉  Find files", "<cmd>lua require('telescope.builtin').fd()<cr>"),

			dashboard.button("r", "  Find recent files", "<cmd>lua require('telescope.builtin').oldfiles()<cr>"),

      dashboard.button("c", "󱁻  Go to dotfiles dir", ":cd ~/.dotfiles<cr>"),

			dashboard.button("l", "󰒲  Open lazy menu", "<cmd>Lazy<cr>"),

			dashboard.button("m", "󱌣  Open mason menu", "<cmd>Mason<cr>"),

			dashboard.button("h", "󰓙  Run healthcheck", "<cmd>checkhealth<cr>"),

			dashboard.button("q", "󰅚  Quit Neovim", ":qa<CR>"),
		}
		-- I'll fix this later :P
		-- local handle = io.popen("fortune")
		-- local fortune = handle:read("*a")
		-- handle:close()
		-- dashboard.section.footer.val = fortune

		dashboard.config.opts.noautocmd = true

		vim.cmd([[autocmd User AlphaReady echo 'ready']])

		alpha.setup(dashboard.config)
	end,
}
