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
      "java",
      "javadoc",
      "kotlin",
      "groovy",
      "go",
      "gomod",
      "gowork",
      "gosum",
      "python",
      "ninja",
      "rst",
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
