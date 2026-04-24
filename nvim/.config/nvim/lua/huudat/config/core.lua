local M = {}

M.icons = {
  dap = {
    Stopped = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
    Breakpoint = " ",
    BreakpointCondition = " ",
    BreakpointRejected = { " ", "DiagnosticError" },
    LogPoint = ".>",
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
