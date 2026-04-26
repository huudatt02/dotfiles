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

    local map = function(keys, cmd, desc)
      vim.keymap.set("n", keys, cmd, { desc = desc, silent = true })
    end

    -- build & run
    map("<leader>xb", "<cmd>XcodebuildBuild<cr>", "Build")
    map("<leader>xB", "<cmd>XcodebuildBuildForTesting<cr>", "Build for Testing")
    map("<leader>xr", "<cmd>XcodebuildBuildRun<cr>", "Build & Run")
    map("<leader>xR", "<cmd>XcodebuildRun<cr>", "Run (no build)")

    -- tests
    map("<leader>xt", "<cmd>XcodebuildTest<cr>", "Run Tests")
    map("<leader>xT", "<cmd>XcodebuildTestClass<cr>", "Test Current Class")

    -- project
    map("<leader>xs", "<cmd>XcodebuildSetup<cr>", "Setup Project")
    map("<leader>xS", "<cmd>XcodebuildSelectScheme<cr>", "Select Scheme")
    map("<leader>xd", "<cmd>XcodebuildSelectDevice<cr>", "Select Device")
    map("<leader>xP", "<cmd>XcodebuildPicker<cr>", "Xcode Picker")

    -- utilities
    map("<leader>xl", "<cmd>XcodebuildToggleLogs<cr>", "Toggle Logs")
    map("<leader>xC", "<cmd>XcodebuildCleanBuild<cr>", "Clean Build")

    -- simulator
    map("<leader>xo", "<cmd>XcodebuildBootSimulator<cr>", "Boot Simulator")
    map("<leader>xi", "<cmd>XcodebuildInstallApp<cr>", "Install App")
    map("<leader>xu", "<cmd>XcodebuildUninstallApp<cr>", "Uninstall App")
  end,
}
