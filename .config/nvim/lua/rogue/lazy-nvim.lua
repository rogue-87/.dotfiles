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
		{ import = "rogue.plugins" },
		{ import = "rogue.plugins.ui" },
		{ import = "rogue.plugins.ui.themes" },
		{ import = "rogue.plugins.editor" },
		{ import = "rogue.plugins.coding" },
		{ import = "rogue.plugins.coding.snips" },
		-- { import = "rogue.plugins.stats" },
		{ import = "rogue.plugins.utils" },
	},
	ui = {
		size = {
			width = 0.8,
			height = 0.8,
		},
		wrap = false,
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
