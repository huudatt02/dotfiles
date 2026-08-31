return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "theHamsta/nvim-dap-virtual-text",
    "nvim-neotest/nvim-nio",
    "mfussenegger/nvim-dap-python",
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")
    local dap_virtual_text = require("nvim-dap-virtual-text")

    dap_virtual_text.setup()
    dapui.setup()

    require("dap-python").setup("debugpy-adapter")

    vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

    local signs = {
      DapStopped = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
      DapBreakpoint = { " ", "DiagnosticError" },
      DapBreakpointCondition = { " ", "DiagnosticInfo" },
      DapBreakpointRejected = { " ", "DiagnosticError" },
      DapLogPoint = { ".>", "DiagnosticInfo" },
    }

    for name, sign in pairs(signs) do
      vim.fn.sign_define(name, {
        text = sign[1],
        texthl = sign[2],
        linehl = sign[3],
      })
    end

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
  -- stylua: ignore
  keys = {
    { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
    { "<leader>dc", function() require("dap").continue() end, desc = "Start/Continue" },
    { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
    { "<leader>do", function() require("dap").step_over() end, desc = "Step Over" },
    { "<leader>dO", function() require("dap").step_out() end, desc = "Step Out" },
    { "<leader>dr", function() require("dap").restart() end, desc = "Restart" },
    { "<leader>du", function() require("dapui").toggle() end, desc = "DAP UI Toggle" },
  },
}
