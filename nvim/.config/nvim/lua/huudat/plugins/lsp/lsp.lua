return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "saghen/blink.cmp" },
		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
				callback = function(ev)
					local function map(modes, lhs, rhs, desc, opts)
						opts = vim.tbl_extend("force", {
							buffer = ev.buf,
							desc = desc,
							silent = true,
						}, opts or {})

						vim.keymap.set(modes, lhs, rhs, opts)
					end

                    -- stylua: ignore start
					map("n", "gr", "<cmd>FzfLua lsp_references<cr>", "References")
					map("n", "gd", "<cmd>FzfLua lsp_definitions<cr>", "Goto Definition")
					map("n", "gD", "<cmd>FzfLua lsp_declarations<cr>", "Goto Declaration")
					map("n", "gi", "<cmd>FzfLua lsp_implementations<cr>", "Goto Implementation")
					map("n", "gt", "<cmd>FzfLua lsp_typedefs<cr>", "Goto Type Definition")
					map("n", "<leader>ss", "<cmd>FzfLua lsp_document_symbols<cr>", "Document Symbols")
					map("n", "<leader>sS", "<cmd>FzfLua lsp_workspace_symbols<cr>", "Workspace Symbols")
					map("n", "<leader>sd", "<cmd>FzfLua diagnostics_document<cr>", "Buffer Diagnostics")
					map("n", "<leader>sD", "<cmd>FzfLua diagnostics_workspace<cr>", "Diagnostics")
					map({ "n", "v" }, "<leader>ca", "<cmd>FzfLua lsp_code_actions<cr>", "Code Actions")
                    map("n", "<leader>rn", function()
                        return ":IncRename " .. vim.fn.expand("<cword>")
                    end, "Smart rename", { expr = true })
					map("n", "K", vim.lsp.buf.hover, "Show documentation for what is under cursor")
					map("n", "<leader>rs", "<cmd>LspRestart<CR>", "Restart LSP")
					-- stylua: ignore end
				end,
			})

			vim.lsp.enable("dartls")

			vim.diagnostic.config({
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = " ",
						[vim.diagnostic.severity.WARN] = " ",
						[vim.diagnostic.severity.HINT] = " ",
						[vim.diagnostic.severity.INFO] = " ",
					},
				},
				virtual_text = false,
				underline = true,
				update_in_insert = false,
				severity_sort = true,
			})
		end,
	},

	{
		"rachartier/tiny-inline-diagnostic.nvim",
		event = "VeryLazy",
		priority = 1000,
		opts = {
			preset = "classic",
			transparent_bg = false,
			transparent_cursorline = true,
			options = {
				add_messages = {
					display_count = true,
				},
				multilines = {
					enabled = true,
					always_show = true,
				},
			},
		},
	},

	{
		"b0o/SchemaStore.nvim",
		lazy = true,
		version = false,
	},

	{
		"smjonas/inc-rename.nvim",
		cmd = "IncRename",
		opts = {},
	},
}
