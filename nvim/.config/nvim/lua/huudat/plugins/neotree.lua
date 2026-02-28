return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
	},
	lazy = false,
	opts = {
		close_if_last_window = true,
		popup_border_style = "rounded",
		default_component_configs = {
			indent = {
				with_markers = false,
				with_expanders = true,
				expander_collapsed = "",
				expander_expanded = "",
				expander_highlight = "NeoTreeExpander",
			},
			git_status = {
				symbols = {
					-- Change type
					added = "",
					modified = "",
					deleted = "",
					renamed = "󰁕",
					-- Status type
					untracked = "󰋖",
					ignored = "󰿟",
					unstaged = "",
					staged = "",
					conflict = "",
				},
			},
		},
		window = {
			mappings = {
				["l"] = "toggle_node",
				["h"] = "close_node",
			},
		},
		filesystem = {
			follow_current_file = {
				enabled = true,
				leave_dirs_open = false,
			},
		},
	},
	keys = {
		{ "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Toggle NeoTree" },
	},
}
