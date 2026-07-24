local function map(modes, lhs, rhs, desc, opts)
  vim.keymap.set(
    modes,
    lhs,
    rhs,
    vim.tbl_extend("force", {
      silent = true,
      desc = desc,
    }, opts or {})
  )
end

-- save file
map("n", "<leader>w", "<cmd>w<cr>", "Save file")
map("x", "<leader>w", "<cmd>w<cr>gv", "Save file in visual mode")

-- Quit file
map("n", "<leader>q", "<cmd>confirm q<cr>", "Quit file")
map("n", "<leader>Q", "<cmd>confirm qa<cr>", "Quit all files")

-- buffers
map("n", "[b", "<cmd>bprevious<cr>", "Prev Buffer")
map("n", "]b", "<cmd>bnext<cr>", "Next Buffer")

-- windows
map("n", "<leader>-", "<C-w>s", "Split Window Below", { remap = true })
map("n", "<leader>\\", "<C-w>v", "Split Window Right", { remap = true })

-- better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", "Down", { expr = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", "Down", { expr = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", "Up", { expr = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", "Up", { expr = true })

-- window navigation
map("n", "<C-h>", "<C-w>h", "Go to Left Window", { remap = true })
map("n", "<C-j>", "<C-w>j", "Go to Lower Window", { remap = true })
map("n", "<C-k>", "<C-w>k", "Go to Upper Window", { remap = true })
map("n", "<C-l>", "<C-w>l", "Go to Right Window", { remap = true })

-- resize windows
map("n", "<C-S-Up>", "<cmd>resize +5<cr>", "Increase Window Height")
map("n", "<C-S-Down>", "<cmd>resize -5<cr>", "Decrease Window Height")
map("n", "<C-S-Left>", "<cmd>vertical resize -5<cr>", "Decrease Window Width")
map("n", "<C-S-Right>", "<cmd>vertical resize +5<cr>", "Increase Window Width")

-- move lines
map("n", "<A-Down>", "<cmd>execute 'move .+' . v:count1<cr>==", "Move Down")
map("n", "<A-Up>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", "Move Up")

map("v", "<A-Down>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", "Move Down")
map("v", "<A-Up>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", "Move Up")

-- search navigation
map("n", "n", "'Nn'[v:searchforward].'zv'", "Next Search Result", { expr = true })
map("x", "n", "'Nn'[v:searchforward]", "Next Search Result", { expr = true })
map("o", "n", "'Nn'[v:searchforward]", "Next Search Result", { expr = true })

map("n", "N", "'nN'[v:searchforward].'zv'", "Prev Search Result", { expr = true })
map("x", "N", "'nN'[v:searchforward]", "Prev Search Result", { expr = true })
map("o", "N", "'nN'[v:searchforward]", "Prev Search Result", { expr = true })

-- clear search
map("n", "<esc>", "<cmd>noh<cr><esc>", "Clear Search")

-- undo breakpoints
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

-- better indenting
map("x", "<", "<gv")
map("x", ">", ">gv")

-- diagnostics
local function diagnostic_goto(next, severity)
  return function()
    vim.diagnostic.jump({
      count = (next and 1 or -1) * vim.v.count1,
      severity = severity and vim.diagnostic.severity[severity] or nil,
    })
  end
end

map("n", "]d", diagnostic_goto(true), "Next Diagnostic")
map("n", "[d", diagnostic_goto(false), "Prev Diagnostic")
map("n", "]e", diagnostic_goto(true, "ERROR"), "Next Error")
map("n", "[e", diagnostic_goto(false, "ERROR"), "Prev Error")
map("n", "]w", diagnostic_goto(true, "WARN"), "Next Warning")
map("n", "[w", diagnostic_goto(false, "WARN"), "Prev Warning")

-- quickfix
map("n", "<leader>uq", function()
  local ok, err = pcall(vim.fn.getqflist({ winid = 0 }).winid ~= 0 and vim.cmd.cclose or vim.cmd.copen)

  if not ok and err then
    vim.notify(err, vim.log.levels.ERROR)
  end
end, "Quickfix List")

map("n", "[q", vim.cmd.cprev, "Previous Quickfix")
map("n", "]q", vim.cmd.cnext, "Next Quickfix")
