return {
	"dstein64/nvim-scrollview",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		excluded_filetypes = { "neo-tree", "cmp", "mason" },
		current_only = true,
		base = "right",
		signs_on_startup = { "all" },
		diagnostics_severities = {
			vim.diagnostic.severity.WARN,
			vim.diagnostic.severity.ERROR,
		},
	},
}
