return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter").install({
      "lua",
      "bash",
      "java",
      "javadoc",
      "kotlin",
      "groovy",
      "tsx",
      "typescript",
      "javascript",
      "go",
      "gomod",
      "gowork",
      "gosum",
      "swift",
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
        vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
