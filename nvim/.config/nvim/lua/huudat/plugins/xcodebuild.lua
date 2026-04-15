return {
  "wojciech-kulik/xcodebuild.nvim",
  ft = { "swift" },
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-neo-tree/neo-tree.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    show_build_progress_bar = true,
    logs = {
      auto_open_on_success_tests = false,
      auto_open_on_failed_tests = false,
      auto_open_on_success_build = false,
      auto_open_on_failed_build = true,
      auto_focus = false,
    },
    code_coverage = {
      enabled = true,
    },
  },
}
