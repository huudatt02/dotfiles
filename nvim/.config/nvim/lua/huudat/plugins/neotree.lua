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
			},
		},
		filesystem = {
			follow_current_file = {
				enabled = true,
				leave_dirs_open = false,
			},
		},
	},
	config = function(_, opts)
		local function on_move(data)
			Snacks.rename.on_rename_file(data.source, data.destination)
		end
		local events = require("neo-tree.events")
		opts.event_handlers = opts.event_handlers or {}
		vim.list_extend(opts.event_handlers, {
			{ event = events.FILE_MOVED, handler = on_move },
			{ event = events.FILE_RENAMED, handler = on_move },
		})

		require("neo-tree").setup(opts)
	end,
	keys = {
		{ "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Toggle NeoTree" },
	},
}
