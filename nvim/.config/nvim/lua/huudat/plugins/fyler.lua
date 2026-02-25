return {
	"A7Lavinraj/fyler.nvim",
	dependencies = { "nvim-mini/mini.icons" },
	lazy = false,
	opts = {
		hooks = {
			on_rename = function(src_path, destination_path)
				Snacks.rename.on_rename_file(src_path, destination_path)
			end,
		},
		views = {
			finder = {
				close_on_select = true,
				confirm_simple = false,
				default_explorer = true,
				delete_to_trash = false,
				columns_order = { "git", "diagnostic" },
				columns = {
					git = {
						enabled = true,
						symbols = {
							Untracked = "󰋖 ",
							Added = " ",
							Modified = "󰜥 ",
							Deleted = " ",
							Renamed = "󰁕 ",
							Copied = " ",
							Conflict = " ",
							Ignored = " ",
						},
					},
					diagnostic = {
						enabled = true,
						symbols = {
							Error = " ",
							Warn = " ",
							Info = " ",
							Hint = " ",
						},
					},
				},
			},
		},
	},
	keys = {
		{ "<leader>e", "<cmd>Fyler<CR>", desc = "Open Fyler View" },
	},
}
