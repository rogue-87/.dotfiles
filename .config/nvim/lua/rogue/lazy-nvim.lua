local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	install = { colorscheme = { "github_dark_default" } },
	checker = { enabled = true },
	spec = {
		{
			{
				"folke/which-key.nvim",
				event = "VeryLazy",
				init = function()
					vim.o.timeout = true
					vim.o.timeoutlen = 300
				end,
				opts = {},
			},
			{
				"folke/neoconf.nvim",
				cmd = "Neoconf",
				opts = {},
			},
		},
		{ import = "rogue.plugins" },
		{ import = "rogue.plugins.ui" },
		{ import = "rogue.plugins.ui.themes" },
		{ import = "rogue.plugins.editor" },
		{ import = "rogue.plugins.coding" },
		{ import = "rogue.plugins.coding.snips" },
		{ import = "rogue.plugins.stats" },
		{ import = "rogue.plugins.utils" },
	},
	ui = {
		size = {
			width = 0.8,
			height = 0.8,
		},
		wrap = true,
		border = "none",
	},
	news = {
		lazy = true,
	},
	performance = {
		cache = {
			enabled = true,
		},
	},
})
