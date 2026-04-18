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
    indent = {
      enabled = false,
      animate = { enabled = false },
    },
    input = { enabled = true },
    lazygit = {
      enabled = true,
      configure = false,
    },
    picker = {
      enabled = true,
      previewers = {
        diff = {
          style = "syntax",
        },
      },
      actions = {
        opencode_send = function(...)
          return require("opencode").snacks_picker_send(...)
        end,
      },
      win = {
        input = {
          keys = {
            ["<a-h>"] = false,
            ["<c-j>"] = false,
            ["<c-k>"] = false,
            ["<a-.>"] = { "toggle_hidden", mode = { "i", "n" } },
            ["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
          },
        },
        list = {
          keys = {
            ["<a-h>"] = false,
            ["<c-j>"] = false,
            ["<c-k>"] = false,
            ["<a-.>"] = "toggle_hidden",
          },
        },
      },
    },
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
        },
      },
    },
    toggle = { enabled = true },
    words = { enabled = true },
  },
  config = function(_, opts)
    require("snacks").setup(opts)

    Snacks.toggle.dim():map("<leader>ud")
    Snacks.toggle.indent():map("<leader>ug")
    Snacks.toggle.inlay_hints():map("<leader>uh")
  end,
  -- stylua: ignore start
  keys = {
    -- bufdelete
    { "<leader>bd", function() Snacks.bufdelete.delete() end, desc = "Delete buffer" },
    { "<leader>bo", function() Snacks.bufdelete.other() end, desc = "Delete other buffers" },
    { "<leader>ba", function() Snacks.bufdelete.all() end, desc = "Delete all buffers" },

    -- lazygit
    { "<leader>gg", function() Snacks.lazygit.open() end, desc = "Lazygit" },

    -- terminal
    { "<C-/>", function() Snacks.terminal() end, desc = "Toggle Terminal" },

    -- find
    { "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
    { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
    { "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find Git Files" },
    { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent" },

    -- git
    { "<leader>gb", function() Snacks.picker.git_branches() end, desc = "Git Branches" },
    { "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git Diff (Hunks)" },
    { "<leader>gf", function() Snacks.picker.git_log_file() end, desc = "Git Log File" },
    { "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git Log" },
    { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
    { "<leader>gS", function() Snacks.picker.git_stash() end, desc = "Git Stash" },

    -- gh
    { "<leader>gi", function() Snacks.picker.gh_issue() end, desc = "GitHub Issues (open)" },
    { "<leader>gI", function() Snacks.picker.gh_issue({ state = "all" }) end, desc = "GitHub Issues (all)" },
    { "<leader>gp", function() Snacks.picker.gh_pr() end, desc = "GitHub Pull Requests (open)" },
    { "<leader>gP", function() Snacks.picker.gh_pr({ state = "all" }) end, desc = "GitHub Pull Requests (all)" },

    -- search
    { "<leader>sg", function() Snacks.picker.grep() end, desc = "Grep" },
    { "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
    { "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },
    { "<leader>sw", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },
    { "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
    { "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
    { "<leader>sq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },
    { "<leader>sn", function() Snacks.picker.notifications() end, desc = "Notification History" },
    { "<leader>su", function() Snacks.picker.undo() end, desc = "Undo History" },
  },
  -- stylua: ignore end
}
