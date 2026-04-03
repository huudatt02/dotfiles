local opt = vim.opt

-- Editor UI
opt.number = true
opt.relativenumber = true
opt.cursorline = false
opt.signcolumn = "yes"

opt.termguicolors = true
opt.background = "dark"
opt.showtabline = 0
opt.smoothscroll = true

opt.completeopt = "menu,menuone,noselect"

-- Scrolling
opt.scrolloff = 8
opt.sidescrolloff = 8

-- Indentation & Tabs
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true

opt.smartindent = true
opt.smarttab = true
opt.shiftround = true

opt.wrap = false
opt.breakindent = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true

-- Window Splits
opt.splitright = true
opt.splitbelow = true

-- Input & Editing
opt.clipboard = "unnamedplus"
opt.backspace = "indent,eol,start"

-- Performance & Timing
opt.updatetime = 200
opt.timeoutlen = 300

-- Files & Undo
opt.swapfile = false
opt.backup = false

opt.undofile = true
opt.undolevels = 10000
