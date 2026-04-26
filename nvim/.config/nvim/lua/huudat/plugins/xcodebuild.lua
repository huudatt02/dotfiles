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
  -- stylua: ignore
  keys = {
    -- build & run
    { "<leader>xb", "<cmd>XcodebuildBuild<cr>", desc = "Build" },
    { "<leader>xB", "<cmd>XcodebuildBuildForTesting<cr>", desc = "Build for Testing" },
    { "<leader>xr", "<cmd>XcodebuildBuildRun<cr>", desc = "Build & Run" },
    { "<leader>xR", "<cmd>XcodebuildRun<cr>", desc = "Run (no build)" },

    -- tests
    { "<leader>xt", "<cmd>XcodebuildTest<cr>", desc = "Run Tests" },
    { "<leader>xT", "<cmd>XcodebuildTestClass<cr>", desc = "Test Current Class" },

    -- project
    { "<leader>xs", "<cmd>XcodebuildSetup<cr>", desc = "Setup Project" },
    { "<leader>xS", "<cmd>XcodebuildSelectScheme<cr>", desc = "Select Scheme" },
    { "<leader>xd", "<cmd>XcodebuildSelectDevice<cr>", desc = "Select Device" },
    { "<leader>xp", "<cmd>XcodebuildPicker<cr>", desc = "Xcode Picker" },

    -- utilities
    { "<leader>xl", "<cmd>XcodebuildToggleLogs<cr>", desc = "Toggle Logs" },
    { "<leader>xc", "<cmd>XcodebuildCleanBuild<cr>", desc = "Clean Build" },

    -- simulator
    { "<leader>xo", "<cmd>XcodebuildBootSimulator<cr>", desc = "Boot Simulator" },
    { "<leader>xi", "<cmd>XcodebuildInstallApp<cr>", desc = "Install App" },
    { "<leader>xu", "<cmd>XcodebuildUninstallApp<cr>", desc = "Uninstall App" },
  },
}
