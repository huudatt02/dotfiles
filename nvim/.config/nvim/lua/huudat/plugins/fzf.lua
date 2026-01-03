return {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-mini/mini.icons" },
	opts = {},
	keys = {
		-- Files
		{ "<leader>ff", "<cmd>FzfLua files<CR>", desc = "Files" },
		{ "<leader>fb", "<cmd>FzfLua buffers<CR>", desc = "Buffers" },
		{ "<leader>fo", "<cmd>FzfLua oldfiles<CR>", desc = "Oldfiles" },
		{ "<leader>fh", "<cmd>FzfLua help_tags<CR>", desc = "Help Tags" },

		-- Search
		{ "<leader>sg", "<cmd>FzfLua grep<CR>", desc = "Grep" },
		{ "<leader>sl", "<cmd>FzfLua live_grep<CR>", desc = "Live Grep" },
		{ "<leader>sw", "<cmd>FzfLua grep_cword<CR>", desc = "Grep Word" },
		{ "<leader>sW", "<cmd>FzfLua grep_cWORD<CR>", desc = "Grep WORD" },

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
