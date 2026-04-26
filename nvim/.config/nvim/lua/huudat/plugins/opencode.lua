return {
  "nickjvandyke/opencode.nvim",
  dependencies = {
    "folke/snacks.nvim",
  },
  config = function()
    local opencode_cmd = "opencode --port"
    local snacks_terminal_opts = {
      win = {
        position = "right",
        enter = false,
        on_win = function(win)
          require("opencode.terminal").setup(win.win)
        end,
      },
    }
    vim.g.opencode_opts = {
      server = {
        start = function()
          require("snacks.terminal").open(opencode_cmd, snacks_terminal_opts)
        end,
        stop = function()
          require("snacks.terminal").get(opencode_cmd, snacks_terminal_opts):close()
        end,
        toggle = function()
          require("snacks.terminal").toggle(opencode_cmd, snacks_terminal_opts)
        end,
      },
    }

    vim.o.autoread = true
  end,
  -- stylua: ignore
  keys = {
    { "<leader>ot", function() require("opencode").toggle() end, mode = { "n", "t" }, desc = "Toggle opencode" },
    { "<leader>oa", function() require("opencode").ask("@this: ", { submit = true }) end, mode = { "n", "x" }, desc = "Ask opencode" },
    { "<leader>ob", function() require("opencode").ask("@buffer: ", { submit = true }) end, mode = "n", desc = "Ask opencode buffer" },
    { "<leader>oe", function() require("opencode").select() end, mode = { "n", "x" }, desc = "Execute opencode action…" },
    { "go", function() return require("opencode").operator("@this ") end, mode = { "n", "x" }, expr = true, desc = "Add range to opencode" },
    { "goo", function() return require("opencode").operator("@this ") .. "_" end, mode = "n", expr = true, desc = "Add line to opencode" },
    { "<S-C-u>", function() require("opencode").command("session.half.page.up") end, mode = "n", desc = "opencode half page up" },
    { "<S-C-d>", function() require("opencode").command("session.half.page.down") end, mode = "n", desc = "opencode half page down" },
  },
}
