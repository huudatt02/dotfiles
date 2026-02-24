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
				border = "rounded",
			},
		},
	},

	{
		"mason-org/mason-lspconfig.nvim",
		opts = {
			ensure_installed = {
				"lua_ls",
				"jdtls",
				"gopls",
				"vtsls",
				"superhtml",
				"cssls",
				"eslint",
				"tailwindcss",
				"prismals",
				"yamlls",
				"emmet_language_server",
				"docker_language_server",
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
				"delve",
				"gofumpt",
				"gotestsum",
				"golangci-lint",
				"google-java-format",
				"vscode-spring-boot-tools",
				"java-debug-adapter",
				"java-test",
				"prettierd",
				"js-debug-adapter",
				"yamllint",
				"yamlfmt",
			},
		},
	},
}
