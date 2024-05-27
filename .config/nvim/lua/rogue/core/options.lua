-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.cmd("let g:netrw_liststyle = 3")

vim.opt.number = true
vim.opt.relativenumber = true

-- Tab & Indentation
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.showtabline = 2

-- Search
vim.opt.incsearch = true

vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"

vim.opt.clipboard:append("unnamedplus")

vim.opt.scrolloff = 5

vim.opt.fillchars = "eob: "
vim.opt.sessionoptions = "curdir,folds,globals,help,tabpages,terminal,winsize"

vim.wo.foldcolumn = "0"

vim.cmd("let g:loaded_perl_provider = 0")
