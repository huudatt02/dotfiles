return {
  "catgoose/nvim-colorizer.lua",
  event = "BufReadPre",
  opts = {
    filetypes = {
      "dart",
      "html",
      "css",
      "javascriptreact",
      "typescriptreact",
    },
    options = {
      parsers = {
        css = false,
        css_fn = false,
        names = { enable = false },
        hex = {
          rgb = true,
          rgba = true,
          rrggbb = true,
          aarrggbb = true,
        },
        tailwind = { enable = true },
      },
    },
  },
}
