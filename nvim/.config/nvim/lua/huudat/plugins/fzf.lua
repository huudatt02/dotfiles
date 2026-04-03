return {
	"ibhagwan/fzf-lua",
	cmd = "FzfLua",
	dependencies = { "nvim-mini/mini.icons" },
	opts = function()
		local fzf = require("fzf-lua")

		return {
			ui_select = {
				silent = true,
			},
			keymap = {
				builtin = {
					true,
					["<c-f>"] = "preview-page-down",
					["<c-b>"] = "preview-page-up",
				},
				fzf = {
					true,
					["ctrl-u"] = "half-page-up",
					["ctrl-d"] = "half-page-down",
					["ctrl-f"] = "preview-page-down",
					["ctrl-b"] = "preview-page-up",
				},
			},
			actions = {
				files = {
					true,
					["alt-."] = fzf.actions.toggle_hidden,
				},
			},
			files = {
				hidden = false,
			},
			lsp = {
				code_actions = {
					previewer = false,
				},
			},
		}
	end,
	keys = {
		{ "<leader>ff", "<cmd>FzfLua files<cr>", desc = "Files" },
		{ "<leader>fb", "<cmd>FzfLua buffers<cr>", desc = "Buffers" },
		{ "<leader>fg", "<cmd>FzfLua git_files<cr>", desc = "Git Files" },
		{ "<leader>fr", "<cmd>FzfLua oldfiles<cr>", desc = "Recent Files" },

		{ "<leader>gb", "<cmd>FzfLua git_branches<cr>", desc = "Git Branches" },
		{ "<leader>gc", "<cmd>FzfLua git_commits<cr>", desc = "Git Commits" },
		{ "<leader>gd", "<cmd>FzfLua git_diff<cr>", desc = "Git Diff" },
		{ "<leader>gs", "<cmd>FzfLua git_status<cr>", desc = "Git Status" },
		{ "<leader>gS", "<cmd>FzfLua git_stash<cr>", desc = "Git Stash" },

		{ "<leader>sg", "<cmd>FzfLua live_grep<cr>", desc = "Live Grep" },
		{ "<leader>sb", "<cmd>FzfLua lgrep_curbuf<cr>", desc = "Buffer Grep" },
		{ "<leader>sw", "<cmd>FzfLua grep_cword<cr>", desc = "Search word" },
		{ "<leader>sw", "<cmd>FzfLua grep_visual<cr>", mode = "x", desc = "Search selection" },
		{ "<leader>sl", "<cmd>FzfLua loclist<cr>", desc = "Location List" },
		{ "<leader>sq", "<cmd>FzfLua quickfix<cr>", desc = "Quickfix List" },
		{ "<leader>su", "<cmd>FzfLua undotree<cr>", desc = "Undo Tree" },
	},
}
