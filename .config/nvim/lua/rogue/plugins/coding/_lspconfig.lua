---@diagnostic disable: missing-fields
return {
	"neovim/nvim-lspconfig",
	-- enabled = false,
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = true },
	},
	config = function()
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end
		local lspconfig = require("lspconfig")
		local mason_lspconfig = require("mason-lspconfig")
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		mason_lspconfig.setup_handlers({
			-- Default config for all servers
			function(server_name)
				lspconfig[server_name].setup({
					capabilities = capabilities,
				})
			end,
			["lua_ls"] = function()
				lspconfig["lua_ls"].setup({
					capabilities = capabilities,
					settings = {
						Lua = {
							diagnostics = {
								globals = { "vim" },
							},
							completion = {
								callSnippet = "Replace",
							},
						},
					},
				})
			end,
			["gopls"] = function()
				lspconfig["gopls"].setup({
					capabilities = capabilities,
					filetypes = { "go", "gomod", "gowork", "gotmpl" },
				})
			end,
			["rust_analyzer"] = function()
				require("lspconfig").rust_analyzer.setup({
					settings = {
						["rust-analyzer"] = {
							diagnostics = {
								enable = false,
							},
						},
					},
				})
			end,
			["tsserver"] = function()
				lspconfig["tsserver"].setup({
					capabilities = capabilities,
					init_options = {
						plugins = {
							{
								name = "@vue/typescript-plugin",

								-- (( Default Path )) in case you use npm like normal people would do
								-- location = "/usr/local/lib/node_modules/@vue/typescript-plugin",

								-- (( Preferred Path ))
								location = os.getenv("HOME") .. "/.npm-packages/lib/node_modules/@vue/typescript-plugin/",

								languages = { "javascript", "typescript", "vue" },
							},
						},
					},
					filetypes = {
						"javascript",
						"typescript",
						"vue",
					},
				})
			end,
			["volar"] = function()
				-- in case you have a different user name change it here
				lspconfig["volar"].setup({
					capabilities = capabilities,

					-- (( Normie ))
					filetypes = { "javascript", "typescript", "vue", "json" },

					-- (( WTF ))
					-- filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" },

					init_options = {
						typescript = {
							-- (( Default Path ))
							-- tsdk = "/usr/local/lib/node_modules/typescript/lib"

							-- (( Preferred Path ))
							tsdk = os.getenv("HOME") .. "/.npm-packages/lib/node_modules/typescript/lib/",

							-- (( in case I'm too lazy to install the npm package lol ))
							-- tsdk = os.getenv("HOME") .. "/.local/share/nvim/mason/packages/typescript-language-server/node_modules/typescript/lib/",
						},
					},
				})
			end,
			["emmet_ls"] = function()
				lspconfig["emmet_ls"].setup({
					capabilities = capabilities,
					filetypes = { "html", "typescriptreact", "javascriptreact", "css", "scss" },
				})
			end,
			["eslint"] = function()
				lspconfig["eslint"].setup({
					capabilities = capabilities,
					on_attach = function(client, bufnr)
						vim.api.nvim_create_autocmd("BufWritePre", {
							buffer = bufnr,
							command = "EslintFixAll",
						})
					end,
				})
			end,
		})

		local map = vim.keymap.set
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local opts = { buffer = ev.buf, silent = true }

				opts.desc = "Show LSP references"
				map("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

				opts.desc = "Go to declaration"
				map("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

				opts.desc = "Show LSP definitions"
				map("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

				opts.desc = "Show LSP implementations"
				map("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

				opts.desc = "Show LSP type definitions"
				map("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

				opts.desc = "See available code actions"
				map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

				opts.desc = "Smart rename"
				map("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

				opts.desc = "Show buffer diagnostics"
				map("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

				opts.desc = "Show line diagnostics"
				map("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

				opts.desc = "Go to previous diagnostic"
				map("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

				opts.desc = "Go to next diagnostic"
				map("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

				opts.desc = "Show documentation for what is under cursor"
				map("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

				opts.desc = "Restart LSP"
				map("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
			end,
		})
	end,
}
