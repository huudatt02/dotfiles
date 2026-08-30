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
    { "<leader>xb", "<cmd>XcodebuildBuild<cr>", desc = "Build Project", ft = "swift" },
    { "<leader>xB", "<cmd>XcodebuildBuildForTesting<cr>", desc = "Build For Testing", ft = "swift" },
    { "<leader>xr", "<cmd>XcodebuildBuildRun<cr>", desc = "Build & Run Project", ft = "swift" },
    { "<leader>xR", "<cmd>XcodebuildRun<cr>", desc = "Run Project", ft = "swift" },

    -- Tests
    { "<leader>xt", "<cmd>XcodebuildTest<cr>", desc = "Run Tests", ft = "swift" },
    { "<leader>xT", "<cmd>XcodebuildTestClass<cr>", desc = "Run Current Test Class", ft = "swift" },

    -- Project
    { "<leader>xp", "<cmd>XcodebuildPicker<cr>", desc = "Xcode Picker", ft = "swift" },
    { "<leader>xs", "<cmd>XcodebuildSetup<cr>", desc = "Setup Project", ft = "swift" },
    { "<leader>xS", "<cmd>XcodebuildSelectScheme<cr>", desc = "Select Scheme", ft = "swift" },
    { "<leader>xd", "<cmd>XcodebuildSelectDevice<cr>", desc = "Select Device", ft = "swift" },

    -- Utilities
    { "<leader>xl", "<cmd>XcodebuildToggleLogs<cr>", desc = "Toggle Logs", ft = "swift" },
    { "<leader>xc", "<cmd>XcodebuildCleanBuild<cr>", desc = "Clean Build", ft = "swift" },

    -- Simulator
    { "<leader>xo", "<cmd>XcodebuildBootSimulator<cr>", desc = "Boot Simulator", ft = "swift" },
    { "<leader>xi", "<cmd>XcodebuildInstallApp<cr>", desc = "Install App", ft = "swift" },
    { "<leader>xu", "<cmd>XcodebuildUninstallApp<cr>", desc = "Uninstall App", ft = "swift" },
  },
}
