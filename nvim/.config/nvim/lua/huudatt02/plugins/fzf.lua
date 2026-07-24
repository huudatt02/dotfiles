return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-mini/mini.icons" },
  config = function()
    require("fzf-lua").setup({
      "border-fused",
      ui_select = function(fzf_opts, items)
        return vim.tbl_deep_extend("force", fzf_opts, {
          prompt = " ",
          winopts = {
            title = " " .. vim.trim((fzf_opts.prompt or "Select"):gsub("%s*:%s*$", "")) .. " ",
            title_pos = "center",
          },
        }, fzf_opts.kind == "codeaction" and {
          winopts = {
            layout = "vertical",
            -- height is number of items minus 15 lines for the preview, with a max of 80% screen height
            height = math.floor(math.min(vim.o.lines * 0.8 - 16, #items + 4) + 0.5) + 16,
            width = 0.6,
            preview = {
              layout = "vertical",
              vertical = "down:15,border-top",
            },
          },
        } or {
          winopts = {
            width = 0.6,
            -- height is number of items, with a max of 80% screen height
            height = math.floor(math.min(vim.o.lines * 0.8, #items + 4) + 0.5),
          },
        })
      end,
      defaults = {
        formatter = "path.dirname_first",
      },
      winopts = {
        width = 0.8,
        height = 0.8,
        row = 0.5,
        col = 0.5,
      },
      files = {
        cwd_prompt = false,
        hidden = false,
        actions = {
          ["alt-h"] = false,
          ["alt-."] = require("fzf-lua").actions.toggle_hidden,
          ["alt-i"] = require("fzf-lua").actions.toggle_ignore,
        },
      },
      grep = {
        actions = {
          ["alt-h"] = false,
          ["alt-."] = require("fzf-lua").actions.toggle_hidden,
          ["alt-i"] = require("fzf-lua").actions.toggle_ignore,
        },
      },
      lsp = {
        code_actions = {
          previewer = vim.fn.executable("delta") == 1 and "codeaction_native" or nil,
        },
      },
    })
  end,
  -- stylua: ignore
  keys = {
    { "<leader>ff", function() require("fzf-lua").files() end, desc = "Find Files" },
    { "<leader>fb", function() require("fzf-lua").buffers() end, desc = "Buffers" },
    { "<leader>fo", function() require("fzf-lua").oldfiles() end, desc = "Recent Files" },
    { "<leader>fq", function() require("fzf-lua").quickfix() end, desc = "Quickfix List" },

    { "<leader>gf", function() require("fzf-lua").git_files() end, desc = "Git Files" },
    { "<leader>gs", function() require("fzf-lua").git_status() end, desc = "Git Status" },
    { "<leader>gd", function() require("fzf-lua").git_diff() end, desc = "Git Diff" },
    { "<leader>gc", function() require("fzf-lua").git_commits() end, desc = "Git Commits" },
    { "<leader>gC", function() require("fzf-lua").git_bcommits() end, desc = "Git Buffer Commits" },
    { "<leader>gb", function() require("fzf-lua").git_branches() end, desc = "Git Branches" },
    { "<leader>gS", function() require("fzf-lua").git_stash() end, desc = "Git Stash" },

    { "<leader>sg", function() require("fzf-lua").live_grep() end, desc = "Live Grep" },
    { "<leader>sb", function() require("fzf-lua").lgrep_curbuf() end, desc = "Live Grep Buffer" },
    { "<leader>sw", function() require("fzf-lua").grep_cword() end, desc = "Grep Word" },
    { "<leader>sW", function() require("fzf-lua").grep_cWORD() end, desc = "Grep WORD" },
    { "<leader>sv", function() require("fzf-lua").grep_visual() end, mode = "v", desc = "Grep Selection" },
    { "<leader>sq", function() require("fzf-lua").lgrep_quickfix() end, desc = "Live Grep Quickfix" },

    { "<leader>ut", function() require("fzf-lua").undotree() end, desc = "Undo Tree" },
  },
}
