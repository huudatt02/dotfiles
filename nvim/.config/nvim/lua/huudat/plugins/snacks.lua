return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		indent = {
			enabled = false,
			animate = {
				enabled = false,
			},
		},
		input = { enabled = true },
		lazygit = { enabled = true },
		picker = {
			enabled = true,
			actions = {
				opencode_send = function(...)
					return require("opencode").snacks_picker_send(...)
				end,
			},
			win = {
				input = {
					keys = {
						["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
					},
				},
			},
		},
		notifier = { enabled = true },
		scope = { enabled = true },
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
		toggle = { enabled = true },
		words = { enabled = true },
	},
	config = function(_, opts)
		require("snacks").setup(opts)

		Snacks.toggle.indent():map("<leader>ug")
		Snacks.toggle.dim():map("<leader>ud")

		if vim.lsp.inlay_hint then
			Snacks.toggle.inlay_hints():map("<leader>uh")
		end
	end,
	-- stylua: ignore start
	keys = {
		-- bufdelete
		{ "<leader>bd", function() Snacks.bufdelete.delete() end, desc = "Delete buffer" },
		{ "<leader>bo", function() Snacks.bufdelete.other() end, desc = "Delete other buffers" },
		{ "<leader>ba", function() Snacks.bufdelete.all() end, desc = "Delete all buffers" },

		-- lazygit
		{ "<leader>gg", function() Snacks.lazygit.open() end, desc = "Lazygit" },

		-- terminal
		{ "<C-s>", function() Snacks.terminal.toggle() end, desc = "Toggle Terminal" },

		-- notifier
		{ "<leader>n", function() Snacks.picker.notifications() end, desc = "Notification History" },
	},
	-- stylua: ignore end
}
