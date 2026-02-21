return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		bigfile = { enabled = true },
		bufdelete = { enabled = true },
		input = { enabled = true },
		picker = { enabled = true },
		notifier = { enabled = true },
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
        -- stylua: ignore start
		-- bufdelete
		{ "<leader>bd", function() Snacks.bufdelete.delete() end, desc = "Delete buffer" },
		{ "<leader>bo", function() Snacks.bufdelete.other() end, desc = "Delete other buffers" },
		{ "<leader>ba", function() Snacks.bufdelete.all() end, desc = "Delete all buffers" },

		-- terminal
		{ "<C-\\>", function() Snacks.terminal.toggle() end, desc = "Toggle Terminal" },

		-- notifier
		{ "<leader>n", function() Snacks.notifier.show_history() end, desc = "Notification History" },
        -- stylua: ignore end
	},
}
