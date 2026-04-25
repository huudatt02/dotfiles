return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-mini/mini.icons",
  },
  opts = function()
    local icons = require("huudat.config.core").icons

    local mode = {
      "mode",
      fmt = function(str)
        if vim.fn.winwidth(0) < 100 then
          return str:sub(1, 1)
        end
        return str
      end,
    }

    local branch = { "branch", icon = "" }

    local diagnostics = {
      "diagnostics",
      symbols = {
        error = icons.diagnostics.Error,
        warn = icons.diagnostics.Warn,
        info = icons.diagnostics.Info,
        hint = icons.diagnostics.Hint,
      },
      padding = { left = 0, right = 1 },
    }

    local diff = {
      "diff",
      symbols = {
        added = icons.git.added,
        modified = icons.git.modified,
        removed = icons.git.removed,
      },
      padding = { left = 0, right = 1 },
    }

    local filesize = function()
      local size = math.max(vim.fn.line2byte(vim.fn.line("$") + 1) - 1, 0)
      if size < 1024 then
        return string.format("%dB", size)
      elseif size < 1048576 then
        return string.format("%.2fKB", size / 1024)
      else
        return string.format("%.2fMB", size / 1048576)
      end
    end

    return {
      options = {
        theme = "auto",
        component_separators = "",
        section_separators = "",
        disabled_filetypes = {},
        globalstatus = false,
      },
      sections = {
        lualine_a = { mode },
        lualine_b = { branch, diff, diagnostics },
        lualine_c = {
          {
            "filetype",
            icon_only = true,
            separator = "",
            padding = { left = 1, right = 0 },
          },
          {
            "filename",
            padding = { left = 0, right = 0 },
          },
        },
        lualine_x = { filesize, "encoding" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      extensions = { "lazy", "mason", "neo-tree", "quickfix", "nvim-dap-ui" },
    }
  end,
}
