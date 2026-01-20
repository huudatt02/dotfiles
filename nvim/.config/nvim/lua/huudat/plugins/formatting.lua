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
			html = { "biome-check" },
			css = { "biome-check" },
			javascript = { "biome-check" },
			typescript = { "biome-check" },
			javascriptreact = { "biome-check" },
			typescriptreact = { "biome-check" },
			json = { "biome-check" },
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
