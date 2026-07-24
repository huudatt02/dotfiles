return {
  "nvim-flutter/flutter-tools.nvim",
  ft = { "dart" },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    ui = {
      border = "rounded",
    },
    widget_guides = {
      enabled = true,
    },
    closing_tags = {
      enabled = true,
    },
    dev_log = {
      enabled = true,
      filter = nil,
      notify_errors = false,
      open_cmd = "12split",
      focus_on_open = true,
    },
  },
}
