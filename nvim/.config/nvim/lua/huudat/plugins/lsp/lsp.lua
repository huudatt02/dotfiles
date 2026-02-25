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
					map("n", "gr", function() Snacks.picker.lsp_references() end, "References")
					map("n", "gd", function() Snacks.picker.lsp_definitions() end, "Goto Definition")
					map("n", "gD", function() Snacks.picker.lsp_declarations() end, "Goto Declaration")
					map("n", "gi", function() Snacks.picker.lsp_implementations() end, "Goto Implementation")
					map("n", "gt", function() Snacks.picker.lsp_type_definitions() end, "Goto Type Definition")
					map("n", "<leader>ss", function() Snacks.picker.lsp_symbols() end, "LSP Symbols")
					map("n", "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, "LSP Workspace Symbols")
					map("n", "<leader>sd", function() Snacks.picker.diagnostics_buffer() end, "Buffer Diagnostics")
					map("n", "<leader>sD", function() Snacks.picker.diagnostics() end, "Diagnostics")
					map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code actions")
                    map("n", "<leader>rn", function()
                        return ":IncRename " .. vim.fn.expand("<cword>")
                    end, "Smart rename", { expr = true })
					map("n", "K", vim.lsp.buf.hover, "Show documentation for what is under cursor")
					map("n", "<leader>rs", "<cmd>LspRestart<CR>", "Restart LSP")
					-- stylua: ignore end
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

	{
		"smjonas/inc-rename.nvim",
		opts = {
			input_buffer_type = "snacks",
		},
	},
}
