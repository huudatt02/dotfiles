return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	opts = {
		ui = {
			icons = {
				package_installed = "✓",
				package_pending = "➜",
				package_uninstalled = "✗",
			},
		},
	},
	config = function(_, opts)
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")
		local mason_tool_installer = require("mason-tool-installer")

		mason.setup(opts)

		mason_lspconfig.setup({
			ensure_installed = {
				"lua_ls",
				"ts_ls",
				"gopls",
				"jdtls",
				"pyright",
				"biome",
				"superhtml",
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
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"stylua",
				"gofumpt",
				"gotestsum",
				"golangci-lint",
				"google-java-format",
				"java-debug-adapter",
				"ruff",
				"yamlfmt",
			},
		})
	end,
}
