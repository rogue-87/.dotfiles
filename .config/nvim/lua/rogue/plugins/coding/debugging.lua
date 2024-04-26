return {
	"mfussenegger/nvim-dap",
	event = { "BufReadPre", "BufNewFile" },
	enabled = false,
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
	},
	config = function()
		local dap, dapui = require("dap"), require("dapui")

		dapui.setup()

		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end

		local function map(mode, lhs, rhs, opts)
			vim.keymap.set(mode, lhs, rhs, opts)
		end
		local opts = {}

		opts.desc = "DAP Toggle Breakpoint"
		map("n", "<Leader>dt", function() dap.toggle_breakpoint() end, opts)

		opts.desc = "DAP continue" map("n", "<leader>dc", function() dap.continue() end, opts)
	end,
}
