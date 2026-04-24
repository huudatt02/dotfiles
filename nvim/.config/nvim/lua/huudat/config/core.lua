local M = {}

M.icons = {
  dap = {
    Stopped = { text = "󰁕 ", texthl = "DiagnosticWarn", linehl = "DapStoppedLine" },
    Breakpoint = { text = " " },
    BreakpointCondition = { text = " " },
    BreakpointRejected = { text = " ", texthl = "DiagnosticError" },
    LogPoint = { text = ".>" },
  },
  diagnostics = {
    Error = " ",
    Warn = " ",
    Hint = " ",
    Info = " ",
  },
  git = {
    added = " ",
    modified = "󰜥 ",
    removed = " ",
  },
  kinds = {
    Text = "󰉿 ",
    Method = "󰊕 ",
    Function = "󰊕 ",
    Constructor = "󰒓 ",

    Field = "󰜢 ",
    Variable = "󰀫 ",
    Property = "󰖷 ",

    Class = "󰠱 ",
    Interface = "󰒪 ",
    Struct = "󰙅 ",
    Module = "󰆧 ",

    Unit = "󰑭 ",
    Value = "󰎠 ",
    Enum = "󰈍 ",
    EnumMember = "󰈍 ",

    Keyword = "󰻾 ",
    Constant = "󰏿 ",

    Snippet = "󰅴 ",
    Color = "󰏘 ",
    File = "󰈔 ",
    Reference = "󰬲 ",
    Folder = "󰉋 ",
    Event = "󱐋 ",
    Operator = "󰪚 ",
    TypeParameter = "󰬛 ",
  },
}

return M
