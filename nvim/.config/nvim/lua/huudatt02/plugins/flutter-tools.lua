return {
  "nvim-flutter/flutter-tools.nvim",
  ft = { "dart" },
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "RobertBrunhage/flutter-riverpod-snippets", lazy = false },
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
    lsp = {
      settings = {
        showTodos = false,
        completeFunctionCalls = true,
        renameFilesWithClasses = "prompt",
        enableSnippets = true,
        updateImportsOnRename = true,
      },
    },
  },
}
