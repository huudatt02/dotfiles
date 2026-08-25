return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    {
      "theHamsta/nvim-dap-virtual-text",
      opts = {},
    },
    "nvim-neotest/nvim-nio",
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")
    dapui.setup()

    vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

    vim.fn.sign_define("DapStopped", {
      text = "󰁕 ",
      texthl = "DiagnosticWarn",
      linehl = "DapStoppedLine",
    })

    vim.fn.sign_define("DapBreakpoint", {
      text = " ",
      texthl = "DiagnosticError",
    })

    vim.fn.sign_define("DapBreakpointCondition", {
      text = " ",
      texthl = "DiagnosticInfo",
    })

    vim.fn.sign_define("DapBreakpointRejected", {
      text = " ",
      texthl = "DiagnosticError",
    })

    vim.fn.sign_define("DapLogPoint", {
      text = ".>",
      texthl = "DiagnosticInfo",
    })

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
