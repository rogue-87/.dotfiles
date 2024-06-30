return {
	-- For color highlighting
	{
		"NvChad/nvim-colorizer.lua",
		event = { "BufReadPre", "BufNewFile" },
		config = true,
	},
	-- For color picking
	{
		"ziontee113/color-picker.nvim",
    enabled = false,
		event = { "BufReadPost", "BufNewFile" },
		keys = {
			{ "<leader>cp", "<cmd>PickColor<cr>", mode = "n", desc = "Pick color" },
		},
		config = function()
			require("color-picker").setup({
				["icons"] = { "󰝤", "" },
				["border"] = "single", -- none | single | double | rounded | solid | shadow
				["keymap"] = {
					["U"] = "<Plug>ColorPickerSlider5Decrease",
					["O"] = "<Plug>ColorPickerSlider5Increase",
				},
				["background_highlight_group"] = "Normal",
				["border_highlight_group"] = "FloatBorder",
				["text_highlight_group"] = "Normal",
			})

			-- vim.cmd([[hi FloatBorder guibg=NONE]]) -- if you don't want weird border background colors around the popup.
		end,
	},
}
