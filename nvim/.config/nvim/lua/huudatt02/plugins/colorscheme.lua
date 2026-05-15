return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    style = "night",
    transparent = true,
    terminal_colors = true,
    styles = {
      sidebars = "transparent",
      floats = "transparent",
    },
    on_colors = function(c)
      c.git.add = c.green
      c.git.change = c.yellow
      c.git.delete = c.red
    end,
    on_highlights = function(hl, c)
      hl.LineNr = { fg = c.orange }
      hl.LineNrAbove = { fg = c.comment }
      hl.LineNrBelow = { fg = c.comment }
      hl.Visual = { bg = "#2e3c64" }
      hl.CursorLine = { bg = "#2e3c64" }
      hl.LspInlayHint = { fg = c.comment, italic = true }

      hl.Pmenu = { fg = c.magenta, bg = c.none }
      hl.PmenuSel = { bg = "#2e3c64" }
      hl.PmenuThumb = { bg = "#35446f" }

      hl.NeoTreeExpander = { fg = c.blue }
      hl.NeoTreeDimText = { fg = c.comment }
      hl.NeoTreeDotfile = { fg = c.comment }
      hl.NeoTreeMessage = { fg = c.comment, italic = true }
    end,
  },
  config = function(_, opts)
    require("tokyonight").setup(opts)
    vim.cmd.colorscheme("tokyonight")
  end,
}
