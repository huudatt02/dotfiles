return {
  {
    "mason-org/mason.nvim",
    opts = {
      ui = {
        border = "rounded",
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
        "bashls",
        "lua_ls",
        "jdtls",
        "gopls",
        "html",
        "cssls",
        "tsgo",
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
        "shfmt",
        "shellcheck",
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
