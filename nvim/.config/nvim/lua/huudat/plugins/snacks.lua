return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		bufdelete = { enabled = true },
		image = { enabled = true },
		indent = {
			enabled = false,
			animate = {
				enabled = false,
			},
		},
		input = { enabled = true },
		picker = { enabled = true },
		quickfile = { enabled = true },
		scroll = { enabled = true },
		statuscolumn = { enabled = true },
		terminal = {
			enabled = true,
			win = {
				wo = {
					winbar = "",
				},
			},
		},
		words = { enabled = true },
	},
	keys = {
        -- bufdelete
		{ "<leader>bd", function() Snacks.bufdelete.delete() end, desc = "Delete buffer" },
		{ "<leader>bo", function() Snacks.bufdelete.other() end, desc = "Delete other buffers" },
		{ "<leader>ba", function() Snacks.bufdelete.all() end, desc = "Delete all buffers" },

        -- terminal
		{ "<leader>te", function() Snacks.terminal.toggle() end, desc = "Toggle Terminal" },
		{ "<leader>tn", function() Snacks.terminal.open() end, desc = "New Terminal" },
	},
}
