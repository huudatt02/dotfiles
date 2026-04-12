return {
  "nvim-neo-tree/neo-tree.nvim",
  cmd = "Neotree",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
  },
  init = function()
    vim.api.nvim_create_autocmd("BufEnter", {
      group = vim.api.nvim_create_augroup("Neotree_start_directory", { clear = true }),
      desc = "Start Neo-tree with directory",
      once = true,
      callback = function(args)
        if package.loaded["neo-tree"] then
          return true
        else
          local stats = vim.uv.fs_stat(vim.api.nvim_buf_get_name(args.buf))
          if stats and stats.type == "directory" then
            require("lazy").load { plugins = { "neo-tree.nvim" } }
            pcall(vim.api.nvim_exec_autocmds, "BufEnter", { group = "NeoTree_NetrwDeferred", buffer = args.buf })
            return true
          end
        end
      end,
    })
  end,
  opts = {
    close_if_last_window = true,
    open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
    popup_border_style = "rounded",
    filesystem = {
      follow_current_file = { enabled = true },
      use_libuv_file_watcher = false,
    },
    default_component_configs = {
      indent = {
        with_markers = false,
        with_expanders = true,
        expander_collapsed = "",
        expander_expanded = "",
        expander_highlight = "NeoTreeExpander",
      },
      icon = {
        folder_closed = "",
        folder_open = "",
        folder_empty = "",
        provider = function(icon, node)
          local text, hl
          local mini_icons = require "mini.icons"
          if node.type == "file" then
            text, hl = mini_icons.get("file", node.name)
          elseif node.type == "directory" then
            text = mini_icons.get("directory", node.name)
            if node:is_expanded() then text = nil end
          end

          if text then icon.text = text end
          if hl then icon.highlight = hl end
        end,
      },
      git_status = {
        symbols = {
          -- Change type
          added = "",
          modified = "",
          deleted = "",
          renamed = "",
          -- Status type
          untracked = "󰋖",
          ignored = "󰿟",
          unstaged = "",
          staged = "",
          conflict = "",
        },
      },
    },
    window = {
      mappings = {
        ["l"] = "open",
        ["h"] = "close_node",
        ["<space>"] = "none",
        ["c"] = {
          function(state)
            local node = state.tree:get_node()
            if not node then
              return
            end

            local path = node:get_id()
            local rel_path = vim.fn.fnamemodify(path, ":.")
            vim.fn.setreg("+", rel_path)
            vim.notify("Copied relative path: " .. rel_path)
          end,
          desc = "Copy relative path",
        },

        ["C"] = {
          function(state)
            local node = state.tree:get_node()
            if not node then
              return
            end

            local abs_path = node:get_id()
            vim.fn.setreg("+", abs_path)
            vim.notify("Copied absolute path: " .. abs_path)
          end,
          desc = "Copy absolute path",
        },

        ["O"] = {
          function(state)
            require("lazy.util").open(state.tree:get_node().path, { system = true })
          end,
          desc = "Open with System Application",
        },
      },
    },
  },
  config = function(_, opts)
    require("neo-tree").setup(opts)
    vim.api.nvim_create_autocmd("TermClose", {
      pattern = "*lazygit",
      callback = function()
        local manager_avail, manager = pcall(require, "neo-tree.sources.manager")
        if manager_avail then
          for _, source in ipairs { "filesystem", "git_status", "document_symbols" } do
            local module = "neo-tree.sources." .. source
            if package.loaded[module] then manager.refresh(require(module).name) end
          end
        end
      end,
    })
  end,
  keys = {
    { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Toggle NeoTree" },
  },
}
