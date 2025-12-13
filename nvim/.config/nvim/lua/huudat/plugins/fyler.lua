return {
	"A7Lavinraj/fyler.nvim",
	dependencies = { "nvim-mini/mini.icons" },
	lazy = false,
	opts = {
		views = {
			finder = {
				close_on_select = true,
				confirm_simple = false,
				default_explorer = false,
				delete_to_trash = false,
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
		{ "<leader>e", "<cmd>Fyler<CR>", desc = "Open Fyler View" },
	},
}
