return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter").install({
      "dart",
      "swift",
      "tsx",
      "typescript",
      "javascript",
      "go",
      "gomod",
      "gosum",
      "gowork",
      "java",
      "javadoc",
      "kotlin",
      "groovy",
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
