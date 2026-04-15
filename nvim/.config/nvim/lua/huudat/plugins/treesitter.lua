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
      "lua",
      "sql",
      "xml",
      "yaml",
      "json",
      "toml",
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
        if not pcall(vim.treesitter.start, ev.buf) then
          return
        end

        local lang = vim.treesitter.language.get_lang(ev.match)
        if lang and vim.treesitter.query.get(lang, "indents") then
          vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end

        if lang and vim.treesitter.query.get(lang, "folds") then
          vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
          vim.wo[0][0].foldmethod = "expr"
        end
      end,
    })
  end,
}
