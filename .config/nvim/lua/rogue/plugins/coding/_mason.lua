return { -- For installing LSPs, DAPs, formatters, linters
	"williamboman/mason.nvim",
	-- enabled = false,
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		-- "jay-babu/mason-nvim-dap.nvim",
	},
	config = function()
		-- The one and only
		local mason = require("mason")
		mason.setup({
			ui = {
				border = "none",
				width = 0.8,
				height = 0.8,
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		-- For installing & configuring LSPs
		local mason_lspconfig = require("mason-lspconfig")
		mason_lspconfig.setup({
			-- LSPs
			ensure_installed = {
				-- Web
				"html",
				"cssls",
				"tsserver",
				"jsonls",
        "volar",

				-- Generic
				"lua_ls",
				"bashls",
				"gopls",
				"rust_analyzer",
			},
			automatic_installation = true,
		})

		-- For installing formatters, linters ... etc
		local mason_tool_installer = require("mason-tool-installer")
		mason_tool_installer.setup({
			-- Formatters, Linters
			ensure_installed = {
				-- Fomratters
				"stylua",
				"prettier",
				"shfmt",
				"isort",

				-- Linters
				"selene",
				"codespell",
				"eslint",
				"stylelint",

				-- Both
			},
			auto_update = true,
		})

		-- For installing & configuring Daps
		--[[ local mason_dap = require("mason-nvim-dap")
		mason_dap.setup({
			ensure_installed = {
				"node2",
				"js",
			},
			automatic_installation = false,
		}) ]]
	end,
}
