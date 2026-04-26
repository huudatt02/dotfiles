return {
  "wojciech-kulik/xcodebuild.nvim",
  ft = { "swift" },
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-neo-tree/neo-tree.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("xcodebuild").setup({
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
    })

    local map = vim.keymap.set

    -- build & run
    map("n", "<leader>xb", "<cmd>XcodebuildBuild<cr>", { desc = "Build Project" })
    map("n", "<leader>xB", "<cmd>XcodebuildBuildForTesting<cr>", { desc = "Build For Testing" })
    map("n", "<leader>xr", "<cmd>XcodebuildBuildRun<cr>", { desc = "Build & Run Project" })
    map("n", "<leader>xR", "<cmd>XcodebuildRun<cr>", { desc = "Run Project" })

    -- tests
    map("n", "<leader>xt", "<cmd>XcodebuildTest<cr>", { desc = "Run Tests" })
    map("n", "<leader>xT", "<cmd>XcodebuildTestClass<cr>", { desc = "Run Current Test Class" })

    -- project
    map("n", "<leader>xp", "<cmd>XcodebuildPicker<cr>", { desc = "Xcode Picker" })
    map("n", "<leader>xs", "<cmd>XcodebuildSetup<cr>", { desc = "Setup Project" })
    map("n", "<leader>xS", "<cmd>XcodebuildSelectScheme<cr>", { desc = "Select Scheme" })
    map("n", "<leader>xd", "<cmd>XcodebuildSelectDevice<cr>", { desc = "Select Device" })

    -- utilities
    map("n", "<leader>xl", "<cmd>XcodebuildToggleLogs<cr>", { desc = "Toggle Logs" })
    map("n", "<leader>xc", "<cmd>XcodebuildCleanBuild<cr>", { desc = "Clean Build" })

    -- simulator
    map("n", "<leader>xo", "<cmd>XcodebuildBootSimulator<cr>", { desc = "Boot Simulator" })
    map("n", "<leader>xi", "<cmd>XcodebuildInstallApp<cr>", { desc = "Install App" })
    map("n", "<leader>xu", "<cmd>XcodebuildUninstallApp<cr>", { desc = "Uninstall App" })
  end,
}
