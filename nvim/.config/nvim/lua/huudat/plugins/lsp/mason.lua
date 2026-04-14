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
        "jdtls",
        "gopls",
        "html",
        "cssls",
        "vtsls",
        "jsonls",
        "yamlls",
        "tailwindcss",
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
        "vscode-spring-boot-tools",
        "google-java-format",
        "java-debug-adapter",
        "java-test",
        "prettierd",
        "eslint_d",
        "yamlfmt",
      },
    },
  },
}
