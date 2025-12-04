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
			hl.LineNr = { fg = c.red }
			hl.LineNrAbove = { fg = c.dark5 }
			hl.LineNrBelow = { fg = c.dark5 }
			hl.EndOfBuffer = { fg = c.dark5 }
		end,
	},
	config = function(_, opts)
		require("tokyonight").setup(opts)
		vim.cmd.colorscheme("tokyonight")
	end,
}
