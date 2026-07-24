return {
  "kevinhwang91/nvim-ufo",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    "kevinhwang91/promise-async",
  },
  opts = {
    provider_selector = function(_, filetype, buftype)
      if buftype ~= "" or filetype == "neo-tree" then
        return ""
      end

      return { "treesitter", "indent" }
    end,
  },
}
