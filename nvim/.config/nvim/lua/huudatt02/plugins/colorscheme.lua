return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    style = "moon",
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
      hl.LineNrAbove = { fg = c.dark3 }
      hl.LineNrBelow = { fg = c.dark3 }
      hl.LspInlayHint = { fg = c.dark3, italic = true }

      hl.Pmenu = { bg = c.none }
      hl.PmenuSel = { bg = "#2f3d66" }
      hl.PmenuThumb = { bg = "#2c395f" }
      hl.CursorLine = { bg = "#2f3d66" }

      hl.NeoTreeExpander = { fg = c.blue }
      hl.NeoTreeDimText = { fg = c.dark3 }
      hl.NeoTreeDotfile = { fg = c.dark3 }
      hl.NeoTreeMessage = { fg = c.dark3, italic = true }
    end,
  },
  config = function(_, opts)
    require("tokyonight").setup(opts)
    vim.cmd.colorscheme("tokyonight")
  end,
}
