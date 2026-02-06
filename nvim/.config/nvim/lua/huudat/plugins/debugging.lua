return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"leoluz/nvim-dap-go",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		require("dap-go").setup()
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
	end,
	keys = {
		{ "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
		{ "<leader>dd", function() require("dap").continue() end, desc = "Start/Continue" },
		{ "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
		{ "<leader>do", function() require("dap").step_over() end, desc = "Step Over" },
		{ "<leader>du", function() require("dap").step_out() end, desc = "Step Out" },
		{ "<leader>dr", function() require("dap").restart() end, desc = "Restart" },
		{ "<leader>dt", function() require("dapui").toggle() end, desc = "DAP UI Toggle" },
	},
}
