return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "BufReadPost",
		opts = {
			suggestion = { enabled = false },
			panel = { enabled = false },
		},
	},

	{
		"nickjvandyke/opencode.nvim",
		dependencies = {
			"folke/snacks.nvim",
		},
		config = function()
			local opencode_cmd = "opencode --port"
			local snacks_terminal_opts = {
				win = {
					position = "right",
					enter = false,
					on_win = function(win)
						require("opencode.terminal").setup(win.win)
					end,
				},
			}
			vim.g.opencode_opts = {
				server = {
					start = function()
						require("snacks.terminal").open(opencode_cmd, snacks_terminal_opts)
					end,
					stop = function()
						require("snacks.terminal").get(opencode_cmd, snacks_terminal_opts):close()
					end,
					toggle = function()
						require("snacks.terminal").toggle(opencode_cmd, snacks_terminal_opts)
					end,
				},
			}

			vim.o.autoread = true

			-- Recommended/example keymaps.
			vim.keymap.set({ "n", "x" }, "<C-a>", function()
				require("opencode").ask("@this: ", { submit = true })
			end, { desc = "Ask opencode" })
			vim.keymap.set({ "n", "x" }, "<C-x>", function()
				require("opencode").select()
			end, { desc = "Execute opencode action…" })
			vim.keymap.set({ "n", "t" }, "<C-.>", function()
				require("opencode").toggle()
			end, { desc = "Toggle opencode" })

			vim.keymap.set({ "n", "x" }, "go", function()
				return require("opencode").operator("@this ")
			end, { expr = true, desc = "Add range to opencode" })
			vim.keymap.set("n", "goo", function()
				return require("opencode").operator("@this ") .. "_"
			end, { expr = true, desc = "Add line to opencode" })

			vim.keymap.set("n", "<S-C-u>", function()
				require("opencode").command("session.half.page.up")
			end, { desc = "opencode half page up" })
			vim.keymap.set("n", "<S-C-d>", function()
				require("opencode").command("session.half.page.down")
			end, { desc = "opencode half page down" })

			-- You may want these if you stick with the opinionated "<C-a>" and "<C-x>" above — otherwise consider "<leader>o".
			vim.keymap.set("n", "+", "<C-a>", { desc = "Increment", noremap = true })
			vim.keymap.set("n", "-", "<C-x>", { desc = "Decrement", noremap = true })
		end,
	},
}
