return {
  "wojciech-kulik/xcodebuild.nvim",
  ft = { "swift" },
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-neo-tree/neo-tree.nvim",
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
  config = function(_, opts)
    require("xcodebuild").setup(opts)

    local function map(lhs, rhs, desc)
      vim.keymap.set("n", lhs, rhs, {
        silent = true,
        desc = desc,
      })
    end

    -- build & run
    map("<leader>xb", "<cmd>XcodebuildBuild<cr>", "Build Project")
    map("<leader>xB", "<cmd>XcodebuildBuildForTesting<cr>", "Build For Testing")
    map("<leader>xr", "<cmd>XcodebuildBuildRun<cr>", "Build & Run Project")
    map("<leader>xR", "<cmd>XcodebuildRun<cr>", "Run Project")

    -- tests
    map("<leader>xt", "<cmd>XcodebuildTest<cr>", "Run Tests")
    map("<leader>xT", "<cmd>XcodebuildTestClass<cr>", "Run Current Test Class")

    -- project
    map("<leader>xp", "<cmd>XcodebuildPicker<cr>", "Xcode Picker")
    map("<leader>xs", "<cmd>XcodebuildSetup<cr>", "Setup Project")
    map("<leader>xS", "<cmd>XcodebuildSelectScheme<cr>", "Select Scheme")
    map("<leader>xd", "<cmd>XcodebuildSelectDevice<cr>", "Select Device")

    -- utilities
    map("<leader>xl", "<cmd>XcodebuildToggleLogs<cr>", "Toggle Logs")
    map("<leader>xc", "<cmd>XcodebuildCleanBuild<cr>", "Clean Build")

    -- simulator
    map("<leader>xo", "<cmd>XcodebuildBootSimulator<cr>", "Boot Simulator")
    map("<leader>xi", "<cmd>XcodebuildInstallApp<cr>", "Install App")
    map("<leader>xu", "<cmd>XcodebuildUninstallApp<cr>", "Uninstall App")
  end,
}
