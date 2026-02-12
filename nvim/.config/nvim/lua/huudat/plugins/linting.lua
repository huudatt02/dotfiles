return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPost", "BufNewFile" },
	opts = {
		events = { "BufEnter", "BufWritePost", "InsertLeave" },
		linters_by_ft = {
			go = { "golangcilint" },
			yaml = { "yamllint" },
		},
	},
	config = function(_, opts)
		local lint = require("lint")
		lint.linters_by_ft = opts.linters_by_ft
		local lint_augroup = vim.api.nvim_create_augroup("nvim-lint", { clear = true })

		vim.api.nvim_create_autocmd(opts.events, {
			group = lint_augroup,
			callback = function()
				local ft = vim.bo.filetype
				if lint.linters_by_ft[ft] then
					lint.try_lint()
				end
			end,
		})
	end,
	keys = {
		{
			"<leader>li",
			function()
				require("lint").try_lint()
			end,
			desc = "Run linter",
		},
	},
}
