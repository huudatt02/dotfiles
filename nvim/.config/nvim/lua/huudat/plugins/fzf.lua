return {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-mini/mini.icons" },
	opts = {},
	keys = {
		-- Files
		{ "<leader>ff", function() require("fzf-lua").files() end, desc = "Files" },
		{ "<leader>fb", function() require("fzf-lua").buffers() end, desc = "Buffers" },
		{ "<leader>fo", function() require("fzf-lua").oldfiles() end, desc = "Oldfiles" },
		{ "<leader>fh", function() require("fzf-lua").help_tags() end, desc = "Help Tags" },

		-- Search
		{ "<leader>sg", function() require("fzf-lua").grep() end, desc = "Grep" },
		{ "<leader>sl", function() require("fzf-lua").live_grep() end, desc = "Live Grep" },
		{ "<leader>sw", function() require("fzf-lua").grep_cword() end, desc = "Grep Word" },
		{ "<leader>sW", function() require("fzf-lua").grep_cWORD() end, desc = "Grep WORD" },

		-- Git
		{ "<leader>gf", function() require("fzf-lua").git_files() end, desc = "Git Files" },
		{ "<leader>gs", function() require("fzf-lua").git_status() end, desc = "Git Status" },
		{ "<leader>gb", function() require("fzf-lua").git_branches() end, desc = "Git Branches" },
		{ "<leader>gc", function() require("fzf-lua").git_commits() end, desc = "Git Commits" },
		{ "<leader>gC", function() require("fzf-lua").git_bcommits() end, desc = "Git Bcommits" },

		-- Misc
		{ "<leader>ut", function() require("fzf-lua").undotree() end, desc = "Undotree" },
	},
}
