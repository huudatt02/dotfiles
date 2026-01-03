local opt = vim.opt

-- Show number
opt.relativenumber = true
opt.number = true

-- Tab and indent
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true
opt.smarttab = true
opt.smartindent = true
opt.breakindent = true
opt.wrap = false
opt.scrolloff = 8
opt.sidescrolloff = 8

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true

-- UI
opt.cursorline = false
opt.showtabline = 0
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

-- Split windows
opt.splitright = true
opt.splitbelow = true

-- Data entry
opt.clipboard = "unnamedplus"
opt.backspace = "indent,eol,start"

-- File
opt.swapfile = false
opt.backup = false
opt.undofile = true
