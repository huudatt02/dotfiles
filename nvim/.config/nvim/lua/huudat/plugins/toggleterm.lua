return {
	"akinsho/toggleterm.nvim",
	event = "VeryLazy",
	version = "*",
	config = function()
		require("toggleterm").setup({
			open_mapping = [[<c-\>]],
		})

		local function set_terminal_keymaps()
			local opts = { buffer = 0 }
			local maps = {
				["<esc>"] = [[<C-\><C-n>]],
				["jk"] = [[<C-\><C-n>]],
				["<C-h>"] = [[<Cmd>wincmd h<CR>]],
				["<C-j>"] = [[<Cmd>wincmd j<CR>]],
				["<C-k>"] = [[<Cmd>wincmd k<CR>]],
				["<C-l>"] = [[<Cmd>wincmd l<CR>]],
				["<C-w>"] = [[<C-\><C-n><C-w>]],
			}
			for k, v in pairs(maps) do
				vim.keymap.set("t", k, v, opts)
			end
		end

		vim.api.nvim_create_autocmd("TermOpen", {
			pattern = "term://*",
			callback = set_terminal_keymaps,
		})
	end,
}
