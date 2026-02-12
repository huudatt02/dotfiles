return {
	"ibhagwan/fzf-lua",
	cmd = "FzfLua",
	dependencies = { "nvim-mini/mini.icons" },
	config = function()
		local fzf = require("fzf-lua")
		local actions = fzf.actions
		fzf.setup({
			keymap = {
				builtin = {
					["<C-b>"] = "preview-page-up",
					["<C-f>"] = "preview-page-down",
				},
				fzf = {
					["ctrl-b"] = "preview-page-up",
					["ctrl-f"] = "preview-page-down",
					["ctrl-u"] = "half-page-up",
					["ctrl-d"] = "half-page-down",
				},
			},
			fzf_colors = true,
			ui_select = {
				silent = true,
			},
			files = {
				actions = {
					["alt-."] = { actions.toggle_hidden },
				},
			},
			grep = {
				actions = {
					["alt-."] = { actions.toggle_hidden },
				},
			},
			lsp = {
				code_actions = {
					previewer = false,
				},
			},
		})
	end,
	keys = {
		-- Files
		{ "<leader>ff", "<cmd>FzfLua files<CR>", desc = "Files" },
		{ "<leader>fb", "<cmd>FzfLua buffers<CR>", desc = "Buffers" },
		{ "<leader>fg", "<cmd>FzfLua git_files<CR>", desc = "Git Files" },
		{ "<leader>fl", "<cmd>FzfLua blines<CR>", desc = "Current Buffer Lines" },

		-- Search
		{ "<leader>sg", "<cmd>FzfLua grep<CR>", desc = "Grep" },
		{ "<leader>sG", "<cmd>FzfLua live_grep<CR>", desc = "Live Grep" },
		{ "<leader>sw", "<cmd>FzfLua grep_cword<CR>", desc = "Grep Word" },
		{ "<leader>sW", "<cmd>FzfLua grep_cWORD<CR>", desc = "Grep WORD" },
		{ "<leader>sq", "<cmd>FzfLua quickfix<CR>", desc = "Quickfix List" },
		{ "<leader>sl", "<cmd>FzfLua loclist<CR>", desc = "Location List" },

		-- Git
		{ "<leader>gs", "<cmd>FzfLua git_status<CR>", desc = "Git Status" },
		{ "<leader>gb", "<cmd>FzfLua git_branches<CR>", desc = "Git Branches" },
		{ "<leader>gc", "<cmd>FzfLua git_commits<CR>", desc = "Git Commits" },
		{ "<leader>gC", "<cmd>FzfLua git_bcommits<CR>", desc = "Git Bcommits" },

		-- Misc
		{ "<leader>ut", "<cmd>FzfLua undotree<CR>", desc = "Undotree" },
	},
}
