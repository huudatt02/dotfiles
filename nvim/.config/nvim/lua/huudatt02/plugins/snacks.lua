-- Terminal Mappings
local function term_nav(dir)
  return function(self)
    return self:is_floating() and "<c-" .. dir .. ">" or vim.schedule(function()
      vim.cmd.wincmd(dir)
    end)
  end
end

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = { enabled = true },
    image = { enabled = true },
    indent = {
      enabled = false,
      animate = { enabled = false },
    },
    input = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    terminal = {
      enabled = true,
      win = {
        wo = {
          winbar = "",
        },
        keys = {
          nav_h = { "<C-h>", term_nav("h"), desc = "Go to Left Window", expr = true, mode = "t" },
          nav_j = { "<C-j>", term_nav("j"), desc = "Go to Lower Window", expr = true, mode = "t" },
          nav_k = { "<C-k>", term_nav("k"), desc = "Go to Upper Window", expr = true, mode = "t" },
          nav_l = { "<C-l>", term_nav("l"), desc = "Go to Right Window", expr = true, mode = "t" },
          hide_slash = { "<C-/>", "hide", desc = "Hide Terminal", mode = "t" },
          hide_underscore = { "<c-_>", "hide", desc = "which_key_ignore", mode = "t" },
        },
      },
    },
    toggle = { enabled = true },
    words = { enabled = true },
    styles = {
      notification_history = {
        width = 0.8,
        height = 0.6,
      },
    },
  },
  config = function(_, opts)
    require("snacks").setup(opts)

    Snacks.toggle.dim():map("<leader>ud")
    Snacks.toggle.indent():map("<leader>ug")
    Snacks.toggle.inlay_hints():map("<leader>uh")
  end,
  -- stylua: ignore
  keys = {
    -- bufdelete
    { "<leader>bd", function() Snacks.bufdelete.delete() end, desc = "Delete buffer" },
    { "<leader>bo", function() Snacks.bufdelete.other() end, desc = "Delete other buffers" },
    { "<leader>ba", function() Snacks.bufdelete.all() end, desc = "Delete all buffers" },

    -- terminal
    { "<C-/>", function() Snacks.terminal() end, desc = "Toggle Terminal" },
    { "<C-_>", function() Snacks.terminal() end, desc = "which_key_ignore" },

    { "<leader>n", function() Snacks.notifier.show_history() end, desc = "Notification History" },
  },
}
