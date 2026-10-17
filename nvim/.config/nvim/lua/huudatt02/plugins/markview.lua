return {
  "OXY2DEV/markview.nvim",
  lazy = false,
  config = function()
    vim.g.markview_blink_loaded = true
    vim.g.markview_alpha = 0.4

    require("markview").setup({})
  end,
}
