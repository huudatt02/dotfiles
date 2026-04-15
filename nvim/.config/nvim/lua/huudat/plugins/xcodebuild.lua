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
  keys = {
    -- Build & Run
    { "<leader>xb", "<cmd>XcodebuildBuild<cr>", desc = "Build" },
    { "<leader>xB", "<cmd>XcodebuildBuildForTesting<cr>", desc = "Build for Testing" },
    { "<leader>xr", "<cmd>XcodebuildBuildRun<cr>", desc = "Build & Run" },
    { "<leader>xR", "<cmd>XcodebuildRun<cr>", desc = "Run (no build)" },

    -- Tests
    { "<leader>xt", "<cmd>XcodebuildTest<cr>", desc = "Run Tests" },
    { "<leader>xT", "<cmd>XcodebuildTestClass<cr>", desc = "Test Current Class" },

    -- Project
    { "<leader>xs", "<cmd>XcodebuildSetup<cr>", desc = "Setup Project" },
    { "<leader>xS", "<cmd>XcodebuildSelectScheme<cr>", desc = "Select Scheme" },
    { "<leader>xd", "<cmd>XcodebuildSelectDevice<cr>", desc = "Select Device" },
    { "<leader>xP", "<cmd>XcodebuildPicker<cr>", desc = "Xcode Picker" },

    -- Utilities
    { "<leader>xl", "<cmd>XcodebuildToggleLogs<cr>", desc = "Toggle Logs" },
    { "<leader>xc", "<cmd>XcodebuildCleanBuild<cr>", desc = "Clean Build" },
    { "<leader>xq", "<cmd>XcodebuildQuickfixLine<cr>", desc = "Quickfix Line" },
    { "<leader>xa", "<cmd>XcodebuildCodeActions<cr>", desc = "Code Actions" },

    -- Simulator
    { "<leader>xo", "<cmd>XcodebuildBootSimulator<cr>", desc = "Boot Simulator" },
    { "<leader>xi", "<cmd>XcodebuildInstallApp<cr>", desc = "Install App" },
    { "<leader>xu", "<cmd>XcodebuildUninstallApp<cr>", desc = "Uninstall App" },
  },
}
