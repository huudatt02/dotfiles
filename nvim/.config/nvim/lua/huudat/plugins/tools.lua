return {
  {
    "christoomey/vim-tmux-navigator",
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
    },
  },

  {
    "catgoose/nvim-colorizer.lua",
    event = "BufReadPre",
    opts = {
      filetypes = {
        "dart",
        "html",
        "css",
        "javascriptreact",
        "typescriptreact",
      },
      options = {
        parsers = {
          css = false,
          css_fn = false,
          names = { enable = false },
          hex = {
            rgb = true,
            rgba = true,
            rrggbb = true,
            aarrggbb = true,
          },
          tailwind = { enable = true },
        },
      },
    },
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "helix",
      spec = {
        {
          mode = { "n", "x" },
          { "<leader>b", group = "Buffers", icon = "" },
          { "<leader>c", group = "Code", icon = "" },
          { "<leader>d", group = "Debug", icon = "" },
          { "<leader>e", desc = "Explorer", icon = "" },
          { "<leader>f", group = "Files", icon = "󰈮" },
          { "<leader>g", group = "Git", icon = "" },
          { "<leader>h", group = "Hunks", icon = "" },
          { "<leader>l", group = "LSP", icon = "" },
          { "<leader>o", group = "OpenCode", icon = "󰚩" },
          { "<leader>q", group = "Quit", icon = "󰅙" },
          { "<leader>Q", desc = "Quit All", icon = "󰅙" },
          { "<leader>s", group = "Search", icon = "" },
          { "<leader>t", group = "Test", icon = "󰙨" },
          { "<leader>u", group = "UI", icon = "" },
          { "<leader>x", group = "Xcode", icon = "" },
          { "[", group = "Prev" },
          { "]", group = "Next" },
          { "g", group = "Goto" },
          { "s", group = "Surround" },
          { "z", group = "Fold" },
        },
      },
    },
    -- stylua: ignore start
    keys = {
      { "<leader>?", function() require("which-key").show({ global = false }) end, desc = "Buffer Local Keymaps" },
    },
    -- stylua: ignore end
  },

  {
    "max397574/better-escape.nvim",
    event = "VeryLazy",
    opts = {
      timeout = 300,
      default_mappings = false,
      mappings = {
        i = { j = { k = "<Esc>", j = "<Esc>" } },
      },
    },
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = "markdown",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-mini/mini.icons",
    },
    opts = {},
  },

  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
  },
}
