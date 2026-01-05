return {
	{
		"mason-org/mason.nvim",
		opts = {
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		},
	},

	{
		"mason-org/mason-lspconfig.nvim",
		opts = {
			ensure_installed = {
				"lua_ls",
				"ts_ls",
				"gopls",
				"jdtls",
				"pyright",
				"biome",
				"html",
				"cssls",
				"tailwindcss",
				"emmet_language_server",
				"yamlls",
				"docker_compose_language_service",
			},
			automatic_enable = {
				exclude = {
					"jdtls",
				},
			},
		},
	},

	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		opts = {
			ensure_installed = {
				"stylua",
				"gofumpt",
				"gotestsum",
				"golangci-lint",
				"google-java-format",
				"java-debug-adapter",
				"java-test",
				"ruff",
				"yamlfmt",
			},
		},
	},
}
