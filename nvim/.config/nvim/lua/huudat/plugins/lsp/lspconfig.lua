return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = { "saghen/blink.cmp" },
	config = function()
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local map = vim.keymap.set
				local opts = { buffer = ev.buf, silent = true }

				opts.desc = "Show LSP references"
				map("n", "gr", "<cmd>FzfLua lsp_references<CR>", opts)

				opts.desc = "Show LSP definitions"
				map("n", "gd", "<cmd>FzfLua lsp_definitions<CR>", opts)

				opts.desc = "Go to declaration"
				map("n", "gD", "<cmd>FzfLua lsp_declarations<CR>", opts)

				opts.desc = "Show LSP implementations"
				map("n", "gi", "<cmd>FzfLua lsp_implementations<CR>", opts)

				opts.desc = "Show LSP type definitions"
				map("n", "gt", "<cmd>FzfLua lsp_typedefs<CR>", opts)

				opts.desc = "Show document symbols"
				map("n", "<leader>ls", "<cmd>FzfLua lsp_document_symbols<CR>", opts)

				opts.desc = "Show workspace symbols"
				map("n", "<leader>lS", "<cmd>FzfLua lsp_workspace_symbols<CR>", opts)

				opts.desc = "See available code actions"
				map({ "n", "v" }, "<leader>ca", "<cmd>FzfLua lsp_code_actions<CR>", opts)

				opts.desc = "Smart rename"
				map("n", "<leader>rn", vim.lsp.buf.rename, opts)

				opts.desc = "Show document diagnostics"
				map("n", "<leader>ld", "<cmd>FzfLua diagnostics_document<CR>", opts)

				opts.desc = "Show workspace diagnostics"
				map("n", "<leader>lD", "<cmd>FzfLua diagnostics_workspace<CR>", opts)

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
