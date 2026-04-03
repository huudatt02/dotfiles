return {
	"stevearc/conform.nvim",
	cmd = { "ConformInfo" },
	opts = {
		formatters = {
			["google-java-format"] = {
				prepend_args = { "--aosp" }, -- Ensure 4-space indentation
			},
		},
		formatters_by_ft = {
			lua = { "stylua" },
			go = { "goimports", "gofumpt" },
			java = { "google-java-format" },
			html = { "prettierd" },
			css = { "prettierd" },
			scss = { "prettierd" },
			javascript = { "prettierd" },
			typescript = { "prettierd" },
			javascriptreact = { "prettierd" },
			typescriptreact = { "prettierd" },
			json = { "prettierd" },
			yaml = { "yamlfmt" },
		},
	},
	keys = {
		{
			"<leader>cf",
			function()
				require("conform").format({
					lsp_fallback = true,
					async = false,
					timeout_ms = 3000,
				})
			end,
			mode = { "n", "x" },
			desc = "Format file or range",
		},
	},
}
