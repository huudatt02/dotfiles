return {
  "rachartier/tiny-inline-diagnostic.nvim",
  event = "VeryLazy",
  priority = 1000,
  opts = {
    preset = "classic",
    transparent_bg = false,
    transparent_cursorline = true,
    options = {
      add_messages = {
        display_count = true,
      },
      multilines = {
        enabled = true,
        always_show = true,
      },
    },
  },
}
