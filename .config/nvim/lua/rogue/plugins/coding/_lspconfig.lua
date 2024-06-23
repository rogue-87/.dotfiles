local client = require("vim.lsp.client")
return {
	"neovim/nvim-lspconfig",
	-- enabled = false,
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
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

		-- Manually installed LSPs
		lspconfig["fish_lsp"].setup({
			cmd = { "fish-lsp", "start" },
			filetypes = { "fish" },
		})

		-- LSPs installed using mason.nvim
		mason_lspconfig.setup_handlers({
			-- Default config for all servers
			function(server_name)
				lspconfig[server_name].setup({
					capabilities = capabilities,
				})
			end,
			["lua_ls"] = function()
				lspconfig["lua_ls"].setup({
					on_init = function(client)
						local path = client.workspace_folders[1].name
						if vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc") then
							return
						end
						client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
							runtime = {
								-- Tell the language server which version of Lua you're using
								-- (most likely LuaJIT in the case of Neovim)
								version = "LuaJIT",
							},
							-- Make the server aware of Neovim runtime files
							workspace = {
								checkThirdParty = false,
								library = {
									vim.env.VIMRUNTIME,
									-- Depending on the usage, you might want to add additional paths here.
									-- "${3rd}/luv/library"
									-- "${3rd}/busted/library",
								},
								-- or pull in all of 'runtimepath'. NOTE: this is a lot slower
								-- library = vim.api.nvim_get_runtime_file("", true)
							},
						})
					end,
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
					cmd = { "gopls" },
					capabilities = capabilities,
					filetypes = { "go", "gomod", "gowork", "gotmpl" },
					single_file_support = true,
				})
			end,
			-- Web dev stuff
			["html"] = function()
				lspconfig["html"].setup({
					capabilities = capabilities,
					filetypes = { "html", "templ" },
					init_options = {
						configurationSection = { "html", "css", "javascript" },
						embeddedLanguages = {
							css = true,
							javascript = true,
						},
						provideFormatter = false,
					},
					single_file_support = true,
				})
			end,
			["cssls"] = function()
				lspconfig["cssls"].setup({
					capabilities = capabilities,
				})
			end,
			["css_variables"] = function()
				lspconfig["css_variables"].setup({})
			end,
			["cssmodules_ls"] = function()
				lspconfig["cssmodules_ls"].setup({})
			end,
			["tsserver"] = function()
				lspconfig["tsserver"].setup({
					init_options = {
						plugins = {
							{
								name = "@vue/typescript-plugin",
								location = os.getenv("HOME")
									.. "/.npm/packages/lib/node_modules/@vue/typescript-plugin/",
								languages = { "javascript", "typescript", "vue" },
							},
						},
					},
					--[[ on_attach = function()
					end, ]]
					filetypes = {
						"javascript",
						"typescript",
						-- "vue",
					},
				})
			end,
			["emmet_language_server"] = function()
				lspconfig["emmet_language_server"].setup({
					capabilities = capabilities,
					filetypes = {
						"html",
						"css",
						"scss",
					},
				})
			end,
			["volar"] = function()
				lspconfig["volar"].setup({
					init_options = {
						typescript = {
							tsdk = os.getenv("HOME") .. "/.npm/packages/lib/node_modules/typescript/lib/",
						},
					},
					filetypes = { "vue" },
				})
			end,
			-- End of Web dev stuff
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
