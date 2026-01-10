return {
	"ibhagwan/fzf-lua",
	cmd = "FzfLua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {},
	keys = {
		-- Files
		{ "<leader>ff", "<cmd>FzfLua files<CR>", desc = "Files" },
		{ "<leader>fb", "<cmd>FzfLua buffers<CR>", desc = "Buffers" },
		{ "<leader>fl", "<cmd>FzfLua lines<CR>", desc = "Buffers Lines" },
		{ "<leader>fL", "<cmd>FzfLua blines<CR>", desc = "Current Buffer Lines" },
		{ "<leader>fo", "<cmd>FzfLua oldfiles<CR>", desc = "Oldfiles" },

		-- Search
		{ "<leader>sg", "<cmd>FzfLua grep<CR>", desc = "Grep" },
		{ "<leader>sG", "<cmd>FzfLua live_grep<CR>", desc = "Live Grep" },
		{ "<leader>sw", "<cmd>FzfLua grep_cword<CR>", desc = "Grep Word" },
		{ "<leader>sW", "<cmd>FzfLua grep_cWORD<CR>", desc = "Grep WORD" },

		-- Quickfix / Loclist
		{ "<leader>sq", "<cmd>FzfLua quickfix<CR>", desc = "Quickfix List" },
		{ "<leader>sQ", "<cmd>FzfLua lgrep_quickfix<CR>", desc = "Search Quickfix" },
		{ "<leader>sl", "<cmd>FzfLua loclist<CR>", desc = "Location List" },
		{ "<leader>sL", "<cmd>FzfLua lgrep_loclist<CR>", desc = "Search Loclist" },

		-- Git
		{ "<leader>gf", "<cmd>FzfLua git_files<CR>", desc = "Git Files" },
		{ "<leader>gs", "<cmd>FzfLua git_status<CR>", desc = "Git Status" },
		{ "<leader>gb", "<cmd>FzfLua git_branches<CR>", desc = "Git Branches" },
		{ "<leader>gc", "<cmd>FzfLua git_commits<CR>", desc = "Git Commits" },
		{ "<leader>gC", "<cmd>FzfLua git_bcommits<CR>", desc = "Git Bcommits" },

		-- Misc
		{ "<leader>ut", "<cmd>FzfLua undotree<CR>", desc = "Undotree" },
	},
}
