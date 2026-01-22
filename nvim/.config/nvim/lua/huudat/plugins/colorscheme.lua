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
		on_highlights = function(hl, c)
			hl.LineNr = { fg = c.orange }
			hl.LineNrAbove = { fg = c.dark5 }
			hl.LineNrBelow = { fg = c.dark5 }
			hl.EndOfBuffer = { fg = c.dark5 }
			hl.LspInlayHint = { fg = c.comment, bg = c.none, italic = true }
			hl.diffAdded = { fg = c.green }
			hl.diffChanged = { fg = c.orange }
			hl.diffRemoved = { fg = c.red }
		end,
	},
	config = function(_, opts)
		require("tokyonight").setup(opts)
		vim.cmd.colorscheme("tokyonight")
	end,
}
