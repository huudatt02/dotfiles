return {
	"nvim-neo-tree/neo-tree.nvim",
	cmd = "Neotree",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
	},
	opts = {
		close_if_last_window = true,
		open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
		popup_border_style = "rounded",
		filesystem = {
			follow_current_file = { enabled = true },
			use_libuv_file_watcher = false,
		},
		default_component_configs = {
			indent = {
				with_markers = false,
				with_expanders = true,
				expander_collapsed = "",
				expander_expanded = "",
				expander_highlight = "NeoTreeExpander",
			},
			icon = {
				folder_closed = "",
				folder_open = "",
				folder_empty = "",
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
					unstaged = "",
					staged = "",
					conflict = "",
				},
			},
		},
		window = {
			mappings = {
				["l"] = "open",
				["h"] = "close_node",
				["<space>"] = "none",
				["c"] = {
					function(state)
						local node = state.tree:get_node()
						if not node then
							return
						end

						local path = node:get_id()
						local rel_path = vim.fn.fnamemodify(path, ":.")
						vim.fn.setreg("+", rel_path)
						vim.notify("Copied relative path: " .. rel_path)
					end,
					desc = "Copy relative path",
				},

				["C"] = {
					function(state)
						local node = state.tree:get_node()
						if not node then
							return
						end

						local abs_path = node:get_id()
						vim.fn.setreg("+", abs_path)
						vim.notify("Copied absolute path: " .. abs_path)
					end,
					desc = "Copy absolute path",
				},

				["O"] = {
					function(state)
						require("lazy.util").open(state.tree:get_node().path, { system = true })
					end,
					desc = "Open with System Application",
				},
			},
		},
	},
	keys = {
		{ "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Toggle NeoTree" },
	},
}
