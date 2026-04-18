return {
  "stevearc/conform.nvim",
  cmd = { "ConformInfo" },
  opts = {
    default_format_opts = {
      timeout_ms = 3000,
      async = false,
      quiet = false,
      lsp_format = "fallback",
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
      sh = { "shfmt" },
      bash = { "shfmt" },
    },
    formatters = {
      ["google-java-format"] = {
        prepend_args = { "--aosp" }, -- Ensure 4-space indentation
      },
    },
  },
  config = function(_, opts)
    require("conform").setup(opts)
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
  keys = {
    {
      "<leader>cf",
      function()
        require("conform").format({
          timeout_ms = 3000,
          lsp_format = "fallback",
        })
      end,
      mode = { "n", "x" },
      desc = "Format file or range",
    },
  },
}
