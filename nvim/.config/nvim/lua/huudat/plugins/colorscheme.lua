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
			hl.diffAdded = { fg = c.green, bg = c.none }
			hl.diffChanged = { fg = c.yellow, bg = c.none }
			hl.diffRemoved = { fg = c.red, bg = c.none }
		end,
	},
	config = function(_, opts)
		require("tokyonight").setup(opts)
		vim.cmd.colorscheme("tokyonight")
	end,
}
