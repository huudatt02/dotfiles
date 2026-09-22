local function find_lldb_dap()
  -- macOS: Try lldb-dap with xcrun.
  local xcrun_result = vim.system({ "xcrun", "--find", "lldb-dap" }, { text = true }):wait()
  if xcrun_result.code == 0 then
    local xcrun_dap_path = vim.fn.trim(xcrun_result.stdout)
    if vim.fn.executable(xcrun_dap_path) then
      return xcrun_dap_path
    end
  end

  -- Fallback the lldb-dap in the ${PATH} environment.
  if vim.fn.executable("lldb-dap") == 1 then
    return "lldb-dap"
  end

  vim.notify("lldb-dap not found, add it to your PATH environment variable", vim.log.levels.WARN)
  return ""
end

return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      {
        "theHamsta/nvim-dap-virtual-text",
        opts = {},
      },
      "leoluz/nvim-dap-go",
    },
    config = function()
      local dap = require("dap")

      require("dap-go").setup()

      dap.adapters["lldb-dap"] = {
        type = "executable",
        name = "lldb-dap",
        command = find_lldb_dap(),
        options = {
          -- Uncomment and set a path to enable lldb-dap logging (useful for bug reports).
          -- env = { LLDBDAP_LOG = "/path/to/store/lldb-dap.log" },
        },
      }

      dap.configurations.swift = {
        {
          name = "Launch",
          type = "lldb-dap",
          request = "launch",
          program = function()
            return require("dap.utils").pick_file({ executables = true })
          end,
          cwd = "${workspaceFolder}",
        },
        {
          name = "Launch with arguments",
          type = "lldb-dap",
          request = "launch",
          program = function()
            return require("dap.utils").pick_file({ executables = true })
          end,
          cwd = "${workspaceFolder}",
          args = function()
            local args_str = vim.fn.input("Arguments: ")
            return require("dap.utils").splitstr(args_str)
          end,
        },
        {
          name = "Attach",
          type = "lldb-dap",
          request = "attach",
          pid = function()
            return require("dap.utils").pick_process()
          end,
        },
      }

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
    end,
    -- stylua: ignore
    keys = {
      { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
      { "<leader>dc", function() require("dap").continue() end, desc = "Run/Continue" },
      { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
      { "<leader>dg", function() require("dap").goto_() end, desc = "Go to Line (No Execute)" },
      { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
      { "<leader>dj", function() require("dap").down() end, desc = "Down" },
      { "<leader>dk", function() require("dap").up() end, desc = "Up" },
      { "<leader>do", function() require("dap").step_out() end, desc = "Step Out" },
      { "<leader>dO", function() require("dap").step_over() end, desc = "Step Over" },
      { "<leader>dP", function() require("dap").pause() end, desc = "Pause" },
      { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
      { "<leader>ds", function() require("dap").session() end, desc = "Session" },
      { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
      { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
    },
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup()

      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open({})
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close({})
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close({})
      end
    end,
    -- stylua: ignore
    keys = {
      { "<leader>du", function() require("dapui").toggle({ }) end, desc = "Dap UI" },
      { "<leader>de", function() require("dapui").eval() end, desc = "Eval", mode = {"n", "x"} },
    },
  },
}
