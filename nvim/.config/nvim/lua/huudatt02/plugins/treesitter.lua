return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter").install({
      -- dart
      "dart",
      -- swift
      "swift",
      -- nodejs
      "tsx",
      "typescript",
      "javascript",
      -- golang
      "go",
      "gomod",
      "gosum",
      "gowork",
      -- java
      "java",
      "javadoc",
      "kotlin",
      "groovy",
      -- config / data
      "bash",
      "lua",
      "sql",
      "xml",
      "yaml",
      "json",
      "toml",
      "regex",
      "proto",
      "graphql",
      "gitignore",
      "dockerfile",
      -- docs & editor
      "markdown",
      "markdown_inline",
    })

    vim.api.nvim_create_autocmd("FileType", {
      callback = function(ev)
        pcall(vim.treesitter.start, ev.buf)
      end,
    })
  end,
}
