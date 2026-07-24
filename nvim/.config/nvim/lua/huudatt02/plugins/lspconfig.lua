return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
        callback = function(ev)
          vim.lsp.document_color.enable(true, { bufnr = ev.buf })

          local function map(modes, lhs, rhs, desc)
            vim.keymap.set(modes, lhs, rhs, {
              buffer = ev.buf,
              desc = desc,
              silent = true,
            })
          end

          local function code_actions()
            local has_jdtls = vim.iter(vim.lsp.get_clients({ bufnr = ev.buf })):any(function(client)
              return client.name == "jdtls"
            end)

            if has_jdtls then
              require("fzf-lua").lsp_code_actions({
                previewer = false,
              })
            else
              require("fzf-lua").lsp_code_actions()
            end
          end

          -- stylua: ignore start
          map("n", "grd", function() require("fzf-lua").lsp_definitions() end, "Definitions")
          map("n", "grD", function() require("fzf-lua").lsp_declarations() end, "Declarations")
          map("n", "grr", function() require("fzf-lua").lsp_references() end, "References")
          map("n", "gri", function() require("fzf-lua").lsp_implementations() end, "Implementations")
          map("n", "grt", function() require("fzf-lua").lsp_typedefs() end, "Type Definitions")
          map("n", "grn", vim.lsp.buf.rename, "Rename Symbol")
          map({ "n", "v" }, "gra", code_actions, "Code Actions")
          map("n", "<leader>ls", function() require("fzf-lua").lsp_document_symbols() end, "Document Symbols")
          map("n", "<leader>lS", function() require("fzf-lua").lsp_workspace_symbols() end, "Workspace Symbols")
          map("n", "<leader>ld", function() require("fzf-lua").diagnostics_document() end, "Document Diagnostics")
          map("n", "<leader>lD", function() require("fzf-lua").diagnostics_workspace() end, "Workspace Diagnostics")
          map("n", "K", vim.lsp.buf.hover, "Hover Docs")
          map("n", "<leader>li", "<cmd>checkhealth vim.lsp<cr>", "LSP Info")
          map("n", "<leader>lr", "<cmd>lsp restart<cr>", "LSP Restart")
          -- stylua: ignore end
        end,
      })

      vim.lsp.enable({ "sourcekit" })

      local icons = require("huudatt02.config.icons")
      vim.diagnostic.config({
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
            [vim.diagnostic.severity.WARN] = icons.diagnostics.Warn,
            [vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
            [vim.diagnostic.severity.INFO] = icons.diagnostics.Info,
          },
        },
        virtual_text = false,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      })
    end,
  },

  {
    "b0o/SchemaStore.nvim",
    lazy = true,
    version = false,
  },
}
