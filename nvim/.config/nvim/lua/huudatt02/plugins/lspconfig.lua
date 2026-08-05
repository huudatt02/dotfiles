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

          -- stylua: ignore start
          map("n", "grd", function() Snacks.picker.lsp_definitions() end, "Definitions")
          map("n", "grD", function() Snacks.picker.lsp_declarations() end, "Declarations")
          map("n", "grr", function() Snacks.picker.lsp_references() end, "References")
          map("n", "gri", function() Snacks.picker.lsp_implementations() end, "Implementations")
          map("n", "grt", function() Snacks.picker.lsp_type_definitions() end, "Type Definitions")
          map("n", "grn", vim.lsp.buf.rename, "Rename Symbol")
          map({ "n", "v" }, "gra", vim.lsp.buf.code_action, "Code Actions")
          map("n", "<leader>ls", function() Snacks.picker.lsp_symbols() end, "Document Symbols")
          map("n", "<leader>lS", function() Snacks.picker.lsp_workspace_symbols() end, "Workspace Symbols")
          map("n", "<leader>ld", function() Snacks.picker.diagnostics_buffer() end, "Document Diagnostics")
          map("n", "<leader>lD", function() Snacks.picker.diagnostics() end, "Workspace Diagnostics")
          map("n", "K", vim.lsp.buf.hover, "Hover Docs")
          map("n", "<leader>li", "<cmd>checkhealth vim.lsp<cr>", "LSP Info")
          map("n", "<leader>lr", "<cmd>lsp restart<cr>", "LSP Restart")
          -- stylua: ignore end
        end,
      })

      vim.lsp.enable({ "sourcekit" })

      vim.diagnostic.config({
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.HINT] = " ",
            [vim.diagnostic.severity.INFO] = " ",
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
