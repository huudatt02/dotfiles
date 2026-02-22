vim.g.mapleader = " "

local map = vim.keymap.set

-- Exit insert mode
map("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- Save file
map("n", "<leader>w", "<cmd>w<CR>", { desc = "Save file" })
map("v", "<leader>w", "<cmd>w<CR>gv", { desc = "Save file in visual mode" })

-- Quit file
map("n", "<leader>q", "<cmd>confirm q<CR>", { desc = "Quit file" })
map("n", "<leader>Q", "<cmd>confirm qa<CR>", { desc = "Quit all files" })

-- Split buffer
map("n", "<leader>sh", "<cmd>split<CR>", { desc = "Horizontal split" })
map("n", "<leader>sv", "<cmd>vsplit<CR>", { desc = "Vertical split" })

-- Resize split
map("n", "<C-S-k>", "<cmd>resize -5<CR>", { desc = "Resize split up" })
map("n", "<C-S-j>", "<cmd>resize +5<CR>", { desc = "Resize split down" })
map("n", "<C-S-h>", "<cmd>vertical resize -5<CR>", { desc = "Resize split left" })
map("n", "<C-S-l>", "<cmd>vertical resize +5<CR>", { desc = "Resize split right" })
