return {
  {
    "nvim-mini/mini.icons",
    version = false,
    lazy = true,
    opts = {
      file = {
        [".keep"] = { glyph = "󰊢", hl = "MiniIconsGrey" },
        ["devcontainer.json"] = { glyph = "", hl = "MiniIconsAzure" },
        ["go.mod"] = { glyph = "", hl = "MiniIconsGrey" },
        ["go.sum"] = { glyph = "", hl = "MiniIconsGrey" },
      },
      filetype = {
        env = { glyph = "", hl = "MiniIconsYellow" },
        dotenv = { glyph = "", hl = "MiniIconsYellow" },
        go = { glyph = "", hl = "MiniIconsAzure" },
      },
    },
    init = function()
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
  },

  {
    "nvim-mini/mini.pairs",
    version = false,
    event = "VeryLazy",
    opts = {
      modes = { insert = true, command = true, terminal = false },
      skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
      skip_ts = { "string" },
      skip_unbalanced = true,
      markdown = true,
    },
  },

  {
    "nvim-mini/mini.surround",
    version = false,
    event = "VeryLazy",
    opts = {},
  },
}
