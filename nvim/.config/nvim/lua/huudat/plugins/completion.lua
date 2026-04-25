return {
  "saghen/blink.cmp",
  version = "1.*",
  event = { "InsertEnter", "CmdlineEnter" },
  dependencies = {
    {
      "L3MON4D3/LuaSnip",
      version = "v2.*",
      build = "make install_jsregexp",
    },
    "rafamadriz/friendly-snippets",
  },
  opts = {
    keymap = {
      preset = "enter",
    },
    appearance = {
      nerd_font_variant = "mono",
    },
    completion = {
      accept = {
        auto_brackets = { enabled = true },
      },
      menu = {
        border = "rounded",
        draw = {
          treesitter = { "lsp" },
        },
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
        list = { selection = { preselect = false } },
        menu = {
          auto_show = function(ctx)
            return vim.fn.getcmdtype() == ":"
          end,
        },
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
    local icons = require("huudat.config.core").icons
    opts.appearance = opts.appearance or {}
    opts.appearance.kind_icons = icons.kinds

    require("blink.cmp").setup(opts)
    require("luasnip.loaders.from_vscode").lazy_load()
    require("luasnip.loaders.from_lua").lazy_load({
      paths = { vim.fn.stdpath("config") .. "/lua/huudat/snippets" },
    })
  end,
}
