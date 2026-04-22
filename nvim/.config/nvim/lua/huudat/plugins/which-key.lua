return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "helix",
    spec = {
      {
        mode = { "n", "x" },
        { "<leader>b", group = "Buffers", icon = "" },
        { "<leader>c", group = "Code", icon = "" },
        { "<leader>d", group = "Debug", icon = "" },
        { "<leader>e", desc = "Explorer", icon = "" },
        { "<leader>f", group = "Files", icon = "󰈮" },
        { "<leader>g", group = "Git", icon = "" },
        { "<leader>h", group = "Hunks", icon = "" },
        { "<leader>l", group = "LSP", icon = "" },
        { "<leader>o", group = "OpenCode", icon = "󰚩" },
        { "<leader>q", group = "Quit", icon = "󰅙" },
        { "<leader>Q", desc = "Quit All", icon = "󰅙" },
        { "<leader>s", group = "Search", icon = "" },
        { "<leader>t", group = "Test", icon = "󰙨" },
        { "<leader>u", group = "UI", icon = "" },
        { "<leader>x", group = "Xcode", icon = "" },
        { "[", group = "Prev" },
        { "]", group = "Next" },
        { "g", group = "Goto" },
        { "s", group = "Surround" },
        { "z", group = "Fold" },
      },
    },
  },
  -- stylua: ignore start
  keys = {
    { "<leader>?", function() require("which-key").show({ global = false }) end, desc = "Buffer Local Keymaps" },
  },
  -- stylua: ignore end
}
