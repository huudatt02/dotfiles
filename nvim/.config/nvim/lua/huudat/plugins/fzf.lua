return {
	"ibhagwan/fzf-lua",
	cmd = "FzfLua",
	dependencies = { "nvim-mini/mini.icons" },
	opts = {
		fzf_colors = true,
		ui_select = {
			silent = true,
		},
		lsp = {
			code_actions = {
				previewer = false,
			},
		},
	},
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
