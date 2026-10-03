return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  dependencies = {
    "AndreM222/copilot-lualine",
  },
  opts = function()
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
        error = " ",
        warn = " ",
        hint = " ",
        info = " ",
      },
    }

    local diff = {
      "diff",
      source = function()
        local gitsigns = vim.b.gitsigns_status_dict
        if gitsigns then
          return {
            added = gitsigns.added,
            modified = gitsigns.changed,
            removed = gitsigns.removed,
          }
        end
      end,
    }

    local function xcodebuild_device()
      if vim.g.xcodebuild_platform == "macOS" then
        return " macOS"
      end

      local deviceIcon = ""
      if vim.g.xcodebuild_platform:match("watch") then
        deviceIcon = "􀟤"
      elseif vim.g.xcodebuild_platform:match("tv") then
        deviceIcon = "􀡴 "
      elseif vim.g.xcodebuild_platform:match("vision") then
        deviceIcon = "􁎖 "
      end

      if vim.g.xcodebuild_os then
        return deviceIcon .. " " .. vim.g.xcodebuild_device_name .. " (" .. vim.g.xcodebuild_os .. ")"
      end

      return deviceIcon .. " " .. vim.g.xcodebuild_device_name
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
            function()
              return " "
            end,
            separator = "",
            padding = 0,
          },
          {
            "filetype",
            icon_only = true,
            separator = "",
            padding = 0,
          },
          {
            "filename",
            padding = 0,
          },
        },
        lualine_x = {
          { "' ' .. vim.g.xcodebuild_last_status", color = { fg = "#737aa2" } },
          { "'󰙨 ' .. vim.g.xcodebuild_test_plan", color = { fg = "#c3e88d", bg = "#161622" } },
          { xcodebuild_device, color = { fg = "#ffc777", bg = "#161622" } },
          "copilot",
          "encoding",
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      extensions = { "lazy", "mason", "neo-tree", "quickfix", "nvim-dap-ui" },
    }
  end,
}
