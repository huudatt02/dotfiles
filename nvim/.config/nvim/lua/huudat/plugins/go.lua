return {
  "olexsmir/gopher.nvim",
  ft = { "go" },
  build = function()
    require("gopher.installer").install_deps({ sync = true })
  end,
  opts = {},
}
