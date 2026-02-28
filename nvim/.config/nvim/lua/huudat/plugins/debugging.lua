return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		{
			"theHamsta/nvim-dap-virtual-text",
			opts = {
				virt_text_pos = "eol",
			},
		},
		"nvim-neotest/nvim-nio",
		"leoluz/nvim-dap-go",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")
		dapui.setup()

		require("dap-go").setup()

		for _, adapter in ipairs({ "pwa-node", "pwa-chrome" }) do
			dap.adapters[adapter] = {
				type = "server",
				host = "localhost",
				port = "${port}",
				executable = {
					command = "node",
					args = {
						vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
						"${port}",
					},
				},
			}
		end

        -- stylua: ignore start
		vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticSignError", linehl = "", numhl = "" })
		vim.fn.sign_define("DapBreakpointRejected", { text = "󰜺", texthl = "DiagnosticSignError", linehl = "", numhl = "" })
		vim.fn.sign_define("DapConditionalBreakpoint", { text = "󰈲", texthl = "DiagnosticSignWarn", linehl = "", numhl = "" })
		vim.fn.sign_define("DapStopped", { text = "󰐊", texthl = "DiagnosticSignInfo", linehl = "Visual", numhl = "" })
		-- stylua: ignore end

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
        -- stylua: ignore start
		{ "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
		{ "<leader>dd", function() require("dap").continue() end, desc = "Start/Continue" },
		{ "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
		{ "<leader>do", function() require("dap").step_over() end, desc = "Step Over" },
		{ "<leader>du", function() require("dap").step_out() end, desc = "Step Out" },
		{ "<leader>dr", function() require("dap").restart() end, desc = "Restart" },
		{ "<leader>dt", function() require("dapui").toggle() end, desc = "DAP UI Toggle" },
		-- stylua: ignore end
	},
}
