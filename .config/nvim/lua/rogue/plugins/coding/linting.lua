return {
	"mfussenegger/nvim-lint",
	enabled = false,
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")

		lint.linters_by_ft = {
			css = { "stylelint" },
			scss = { "stylelint" },
			javascript = { "eslint_d" },
			typescript = { "eslint_d" },
			vue = { "eslint" },
			lua = { "selene" },
			markdown = { "codespell" },
		}

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})
	end,
}
