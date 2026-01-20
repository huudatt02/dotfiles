return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "saghen/blink.cmp" },
		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
				callback = function(ev)
					local fzf = require("fzf-lua")
					local function map(modes, lhs, rhs, desc)
						vim.keymap.set(modes, lhs, rhs, {
							buffer = ev.buf,
							desc = desc,
							silent = true,
						})
					end

					map("n", "gr", fzf.lsp_references, "References")
					map("n", "gd", fzf.lsp_definitions, "Go to definition")
					map("n", "gD", fzf.lsp_declarations, "Go to declaration")
					map("n", "gi", fzf.lsp_implementations, "Implementations")
					map("n", "gt", fzf.lsp_typedefs, "Type definitions")
					map("n", "<leader>ls", fzf.lsp_document_symbols, "Document symbols")
					map("n", "<leader>lS", fzf.lsp_workspace_symbols, "Workspace symbols")
					map("n", "<leader>ld", fzf.diagnostics_document, "Document diagnostics")
					map("n", "<leader>lD", fzf.diagnostics_workspace, "Workspace diagnostics")
					map({ "n", "v" }, "<leader>ca", fzf.lsp_code_actions, "Code actions")
					map("n", "<leader>rn", vim.lsp.buf.rename, "Smart rename")
					map("n", "K", vim.lsp.buf.hover, "Show documentation for what is under cursor")
					map("n", "<leader>rs", "<cmd>LspRestart<CR>", "Restart LSP")
				end,
			})

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
		"j-hui/fidget.nvim",
		opts = {
			notification = {
				window = {
					winblend = 0,
				},
			},
		},
	},
}
