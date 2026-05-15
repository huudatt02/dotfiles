return {
  {
    "saghen/blink.cmp",
    version = "1.*",
    event = { "InsertEnter", "CmdlineEnter" },
    opts = {
      keymap = {
        preset = "enter",
      },
      appearance = {
        nerd_font_variant = "mono",
      },
      completion = {
        list = { selection = { preselect = false, auto_insert = true } },
        menu = {
          border = "rounded",
          draw = {
            treesitter = { "lsp" },
          },
        },
        accept = {
          auto_brackets = { enabled = true },
        },
        documentation = {
          auto_show = false,
          window = { border = "rounded" },
        },
        ghost_text = { enabled = true },
      },
      cmdline = {
        keymap = { preset = "inherit" },
        completion = {
          list = { selection = { preselect = false, auto_insert = true } },
          menu = { auto_show = true },
          ghost_text = { enabled = true },
        },
      },
      signature = {
        enabled = true,
        trigger = {
          enabled = false,
          show_on_trigger_character = false,
          show_on_insert_on_trigger_character = false,
        },
        window = { border = "rounded" },
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
      snippets = { preset = "luasnip" },
      fuzzy = { implementation = "prefer_rust_with_warning" },
    },
    opts_extend = { "sources.default" },
    config = function(_, opts)
      local icons = require("huudatt02.config.icons")
      opts.appearance = opts.appearance or {}
      opts.appearance.kind_icons = vim.tbl_extend("force", opts.appearance.kind_icons or {}, icons.kinds)

      require("blink.cmp").setup(opts)
    end,
  },

  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    event = "InsertEnter",
    build = "make install_jsregexp",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    opts = {
      history = true,
      delete_check_events = "TextChanged",
    },
    config = function(_, opts)
      require("luasnip").setup(opts)

      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_lua").lazy_load({
        paths = { vim.fn.stdpath("config") .. "/snippets" },
      })
    end,
  },
}
