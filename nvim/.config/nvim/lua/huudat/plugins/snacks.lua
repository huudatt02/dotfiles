return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		bigfile = { enabled = true },
		bufdelete = { enabled = true },
		input = {
			enabled = true,
			previewers = {
				diff = {
					style = "syntax",
				},
			},
			win = {
				input = {
					keys = {
						["<a-.>"] = { "toggle_hidden", mode = { "i", "n" } },
					},
				},
				list = {
					keys = {
						["<a-.>"] = "toggle_hidden",
					},
				},
			},
		},
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
        { "<leader>n", function() Snacks.picker.notifications() end, desc = "Notification History" },

        -- find
        { "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
        { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
        { "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find Git Files" },

        -- git
        { "<leader>gb", function() Snacks.picker.git_branches() end, desc = "Git Branches" },
        { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
        { "<leader>gS", function() Snacks.picker.git_stash() end, desc = "Git Stash" },
        { "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git Diff (Hunks)" },

        -- search
        { "<leader>sg", function() Snacks.picker.grep() end, desc = "Grep" },
        { "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },
        { "<leader>sw", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },
        { "<leader>sl", function() Snacks.picker.loclist() end, desc = "Location List" },
        { "<leader>sq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },
        { "<leader>su", function() Snacks.picker.undo() end, desc = "Undo History" },
		-- stylua: ignore end
	},
}
