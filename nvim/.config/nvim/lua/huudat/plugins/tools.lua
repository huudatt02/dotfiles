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
    "numToStr/Comment.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    config = function()
      require("ts_context_commentstring").setup({
        enable_autocmd = false,
      })
      require("Comment").setup({
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      })
    end,
  },

  {
    "folke/todo-comments.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
    -- stylua: ignore start
    keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next Todo Comment" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous Todo Comment" },
      { "<leader>st", function() Snacks.picker.todo_comments() end, desc = "Todo" },
      { "<leader>sT", function () Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } }) end, desc = "Todo/Fix/Fixme" },
    },
    -- stylua: ignore end
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
          { "<leader>f", group = "Files", icon = "" },
          { "<leader>g", group = "Git", icon = "" },
          { "<leader>gh", group = "Hunks", icon = "" },
          { "<leader>l", group = "LSP", icon = "" },
          { "<leader>o", group = "OpenCode", icon = "󰚩" },
          { "<leader>q", group = "Quit", icon = "󰅙" },
          { "<leader>Q", desc = "Quit All", icon = "󰅙" },
          { "<leader>s", group = "Search", icon = "" },
          { "<leader>t", group = "Test", icon = "󰙨" },
          { "<leader>u", group = "UI", icon = "" },
          { "<leader>x", group = "Xcode", icon = "" },
          { "[", group = "Prev" },
          { "]", group = "Next" },
          { "g", group = "Goto" },
          { "gs", group = "Surround" },
          { "z", group = "Fold" },
        },
      },
    },
    -- stylua: ignore start
    keys = {
      { "<leader>?", function() require("which-key").show({ global = false }) end, desc = "Buffer Local Keymaps (which-key)" },
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
