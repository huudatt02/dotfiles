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
			hl.LineNrAbove = { fg = c.dark3 }
			hl.LineNrBelow = { fg = c.dark3 }
			hl.EndOfBuffer = { fg = c.dark3 }
			hl.Visual = { bg = "#2d3f76" }
			hl.CursorLine = { bg = "#2e3c64" }
			hl.LspInlayHint = { fg = c.comment, italic = true }

			hl.NeoTreeExpander = { fg = c.blue }
			hl.NeoTreeDimText = { fg = c.dark3 }
			hl.NeoTreeDotfile = { fg = c.dark3 }
			hl.NeoTreeMessage = { fg = c.comment, italic = true }
		end,
	},
	config = function(_, opts)
		require("tokyonight").setup(opts)
		vim.cmd.colorscheme("tokyonight-night")
	end,
}
