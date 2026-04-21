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
      preset = "default",
      ["<CR>"] = { "accept", "fallback" },
    },
    appearance = {
      nerd_font_variant = "mono",
      kind_icons = {
        Text = "󰉿",
        Method = "󰊕",
        Function = "󰊕",
        Constructor = "󰒓",

        Field = "󰜢",
        Variable = "󰀫",
        Property = "󰖷",

        Class = "󰠲",
        Interface = "",
        Struct = "",
        Module = "",

        Unit = "󰑭",
        Value = "󰎠",
        Enum = "󰖽",
        EnumMember = "󰖽",

        Keyword = "󰻾",
        Constant = "󰏿",

        Snippet = "",
        Color = "󰏘",
        File = "󰈔",
        Reference = "󰬲",
        Folder = "󰉋",
        Event = "󱐋",
        Operator = "󰪚",
        TypeParameter = "󰬛",
      },
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
    require("blink.cmp").setup(opts)
    require("luasnip.loaders.from_vscode").lazy_load()
    require("luasnip.loaders.from_lua").lazy_load({
      paths = { vim.fn.stdpath("config") .. "/lua/huudat/snippets" },
    })
  end,
}
