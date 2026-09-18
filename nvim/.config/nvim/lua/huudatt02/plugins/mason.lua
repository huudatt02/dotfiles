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
        "jsonls",
        "yamlls",
        "html",
        "cssls",
        "tsc",
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
        "gofumpt",
        "goimports",
        "golangci-lint",
        "delve",
        "gotestsum",
        "java-test",
        "java-debug-adapter",
        "vscode-spring-boot-tools",
        -- "google-java-format",
        "ktlint",
        "htmlhint",
        "stylelint",
        "prettierd",
        "eslint_d",
        "yamlfmt",
        "yamllint",
        "jsonlint",
      },
    },
  },
}
