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
					timeout_ms = 1000,
				})
			end,
			mode = { "n", "v" },
			desc = "Format file or range",
		},
	},
}
