return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = { "saghen/blink.cmp" },
	config = function()
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local map = vim.keymap.set
				local fzf = require("fzf-lua")
				local opts = { buffer = ev.buf, silent = true }

				opts.desc = "Show LSP references"
				map("n", "gr", fzf.lsp_references, opts)

				opts.desc = "Show LSP definitions"
				map("n", "gd", fzf.lsp_definitions, opts)

				opts.desc = "Go to declaration"
				map("n", "gD", fzf.lsp_declarations, opts)

				opts.desc = "Show LSP implementations"
				map("n", "gi", fzf.lsp_implementations, opts)

				opts.desc = "Show LSP type definitions"
				map("n", "gt", fzf.lsp_typedefs, opts)

				opts.desc = "Show document symbols"
				map("n", "<leader>ls", fzf.lsp_document_symbols, opts)

				opts.desc = "Show workspace symbols"
				map("n", "<leader>lS", fzf.lsp_workspace_symbols, opts)

				opts.desc = "See available code actions"
				map({ "n", "v" }, "<leader>ca", fzf.lsp_code_actions, opts)

				opts.desc = "Smart rename"
				map("n", "<leader>rn", vim.lsp.buf.rename, opts)

				opts.desc = "Show document diagnostics"
				map("n", "<leader>ld", fzf.diagnostics_document, opts)

				opts.desc = "Show workspace diagnostics"
				map("n", "<leader>lD", fzf.diagnostics_workspace, opts)

				opts.desc = "Show documentation for what is under cursor"
				map("n", "K", vim.lsp.buf.hover, opts)

				opts.desc = "Restart LSP"
				map("n", "<leader>rs", "<cmd>LspRestart<CR>", opts)
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
}
