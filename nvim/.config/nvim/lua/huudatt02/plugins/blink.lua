local function get_kind_icon_text(ctx)
  if ctx.source_name ~= "Path" then
    return require("lspkind").symbol_map[ctx.kind] or "" .. ctx.icon_gap
  end

  local is_unknown_type = vim.tbl_contains({ "link", "socket", "fifo", "char", "block", "unknown" }, ctx.item.data.type)
  local mini_icon, _ =
    require("mini.icons").get(is_unknown_type and "os" or ctx.item.data.type, is_unknown_type and "" or ctx.label)

  return (mini_icon or ctx.kind_icon) .. ctx.icon_gap
end

local function get_kind_icon_highlight(ctx)
  if ctx.source_name ~= "Path" then
    return ctx.kind_hl
  end

  local is_unknown_type = vim.tbl_contains({ "link", "socket", "fifo", "char", "block", "unknown" }, ctx.item.data.type)
  local mini_icon, mini_hl =
    require("mini.icons").get(is_unknown_type and "os" or ctx.item.data.type, is_unknown_type and "" or ctx.label)
  return mini_icon ~= nil and mini_hl or ctx.kind_hl
end

return {
  {
    "saghen/blink.cmp",
    version = "1.*",
    dependencies = {
      "onsails/lspkind.nvim",
      "rafamadriz/friendly-snippets",
    },
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
          draw = {
            treesitter = { "lsp" },
            components = {
              kind_icon = {
                text = get_kind_icon_text,
                highlight = get_kind_icon_highlight,
              },
            },
          },
          border = "rounded",
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
        paths = { vim.fn.stdpath("config") .. "/lua/huudatt02/snippets" },
      })
    end,
  },
}
