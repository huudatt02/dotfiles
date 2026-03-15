return {
	{
		"christoomey/vim-tmux-navigator",
		keys = {
			{ "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
			{ "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
			{ "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
			{ "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
		},
	},

	{
		"nvim-mini/mini.icons",
		version = false,
		lazy = true,
		opts = {},
		init = function()
			package.preload["nvim-web-devicons"] = function()
				require("mini.icons").mock_nvim_web_devicons()
				return package.loaded["nvim-web-devicons"]
			end
		end,
	},

	{
		"numToStr/Comment.nvim",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			"JoosepAlviste/nvim-ts-context-commentstring",
		},
		config = function()
			require("ts_context_commentstring").setup({
				enable_autocmd = false,
			})
			require("Comment").setup({
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
			})
		end,
	},

	{
		"laytan/cloak.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {},
		keys = {
			{ "<leader>ct", "<cmd>CloakToggle<cr>", desc = "Toggle cloak" },
		},
	},

	{
		"folke/todo-comments.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
		keys = {
            -- stylua: ignore start
			{ "]t", function() require("todo-comments").jump_next() end, desc = "Next Todo Comment" },
			{ "[t", function() require("todo-comments").jump_prev() end, desc = "Previous Todo Comment" },
			-- stylua: ignore end
		},
	},

	{
		"catgoose/nvim-colorizer.lua",
		event = "BufReadPre",
		opts = {
			filetypes = { "*" },
			options = {
				parsers = {
					css = false,
					names = {
						enable = false,
					},
					hex = {
						default = false,
						rgb = true,
						rrggbb = true,
						rrggbbaa = true,
						aarrggbb = true, -- 0xAARRGGBB
					},
					tailwind = {
						enable = false,
					},
				},
				display = {
					mode = "virtualtext",
					virtualtext = {
						char = "■",
						position = "before",
						hl_mode = "foreground",
					},
				},
			},
		},
	},

	{
		"kevinhwang91/nvim-ufo",
		dependencies = {
			"kevinhwang91/promise-async",
		},
		event = "BufReadPost",
		config = function()
			vim.o.foldcolumn = "0"
			vim.o.foldlevel = 99
			vim.o.foldlevelstart = 99
			vim.o.foldenable = true

			require("ufo").setup({
				provider_selector = function(bufnr, filetype, buftype)
					if filetype == "neo-tree" then
						return ""
					end
					return { "treesitter", "indent" }
				end,
			})
		end,
	},

	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			preset = "helix",
			spec = {
				mode = { "n", "v" },
				{ "<leader>b", group = "Buffers" },
				{ "<leader>c", group = "Code" },
				{ "<leader>d", group = "Debug" },
				{ "<leader>f", group = "Files" },
				{ "<leader>g", group = "Git" },
				{ "<leader>h", group = "Gitsigns" },
				{ "<leader>l", group = "Lint" },
				{ "<leader>r", group = "LSP" },
				{ "<leader>s", group = "Search" },
				{ "<leader>t", group = "Neotest" },
			},
			win = {
				border = "rounded",
			},
		},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},

	{
		"NMAC427/guess-indent.nvim",
		event = "BufReadPost",
		opts = {},
	},

	{
		"windwp/nvim-ts-autotag",
		event = { "BufReadPost", "BufNewFile" },
		opts = {},
	},

	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {},
	},

	{
		"nvim-mini/mini.surround",
		version = false,
		event = "VeryLazy",
		opts = {},
	},
}
