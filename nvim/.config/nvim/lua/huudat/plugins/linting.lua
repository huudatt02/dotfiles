return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    events = { "BufEnter", "BufWritePost", "InsertLeave" },
    linters_by_ft = {
      sh = { "shellcheck" },
      bash = { "shellcheck" },
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      -- go = { "golangcilint" },
    },
  },
  config = function(_, opts)
    local lint = require("lint")
    lint.linters_by_ft = opts.linters_by_ft
    local lint_augroup = vim.api.nvim_create_augroup("nvim-lint", { clear = true })

    vim.api.nvim_create_autocmd(opts.events, {
      group = lint_augroup,
      callback = function()
        local ft = vim.bo.filetype
        if lint.linters_by_ft[ft] then
          lint.try_lint()
        end
      end,
    })
  end,
  -- stylua: ignore start
  keys = {
    { "<leader>ll", function() require("lint").try_lint() end, desc = "Run linter" },
  },
  -- stylua: ignore end
}
