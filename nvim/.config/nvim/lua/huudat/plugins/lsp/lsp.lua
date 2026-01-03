return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "saghen/blink.cmp" },
		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
				callback = function(ev)
					local function map(modes, lhs, rhs, desc)
						vim.keymap.set(modes, lhs, rhs, {
							buffer = ev.buf,
							desc = desc,
							silent = true,
						})
					end
					map("n", "gr", function()
						require("fzf-lua").lsp_references()
					end, "Show LSP references")

					map("n", "gd", function()
						require("fzf-lua").lsp_definitions()
					end, "Show LSP definitions")

					map("n", "gD", function()
						require("fzf-lua").lsp_declarations()
					end, "Go to declaration")

					map("n", "gi", function()
						require("fzf-lua").lsp_implementations()
					end, "Show LSP implementations")

					map("n", "gt", function()
						require("fzf-lua").lsp_typedefs()
					end, "Show LSP type definitions")

					map("n", "gai", function()
						require("fzf-lua").lsp_incoming_calls()
					end, "Incoming Calls")

					map("n", "gao", function()
						require("fzf-lua").lsp_outgoing_calls()
					end, "Outgoing Calls")

					map("n", "<leader>ls", function()
						require("fzf-lua").lsp_document_symbols()
					end, "Show document symbols")

					map("n", "<leader>lS", function()
						require("fzf-lua").lsp_workspace_symbols()
					end, "Show workspace symbols")

					map({ "n", "v" }, "<leader>ca", function()
						require("fzf-lua").lsp_code_actions()
					end, "See available code actions")

					map("n", "<leader>ld", function()
						require("fzf-lua").diagnostics_document()
					end, "Show document diagnostics")

					map("n", "<leader>lD", function()
						require("fzf-lua").diagnostics_workspace()
					end, "Show workspace diagnostics")

					map("n", "<leader>rn", vim.lsp.buf.rename, "Smart rename")
					map("n", "K", vim.lsp.buf.hover, "Show documentation for what is under cursor")
					map("n", "<leader>rs", "<cmd>LspRestart<CR>", "Restart LSP")
				end,
			})

			vim.diagnostic.config({
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = "󰅙 ",
						[vim.diagnostic.severity.WARN] = "󰀦 ",
						[vim.diagnostic.severity.HINT] = "󰠠 ",
						[vim.diagnostic.severity.INFO] = "󰋼 ",
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
