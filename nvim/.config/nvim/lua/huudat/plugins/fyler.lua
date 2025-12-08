return {
	"A7Lavinraj/fyler.nvim",
	dependencies = { "nvim-mini/mini.icons" },
	opts = {
		views = {
			finder = {
				git_status = {
					enabled = true,
					symbols = {
						Untracked = "󰋖",
						Added = "󰐕",
						Modified = "󰛄",
						Deleted = "󰅖",
						Renamed = "󰁕",
						Copied = "󰜥",
						Conflict = "󰈅",
						Ignored = "󰐣",
					},
				},
			},
		},
	},
	keys = {
		{ "<leader>e", function() require('fyler').open() end, desc = "Open Fyler View" },
	},
}
