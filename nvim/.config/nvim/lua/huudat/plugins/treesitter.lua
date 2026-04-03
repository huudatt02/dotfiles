return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter").install({
			-- nodejs
			"javascript",
			"typescript",
			"tsx",
			-- golang
			"go",
			"gomod",
			"gosum",
			"gowork",
			-- java
			"java",
			"javadoc",
			"kotlin",
			"groovy",
			-- dart
			"dart",
			-- config / data
			"xml",
			"sql",
			"json",
			"yaml",
			"proto",
			"graphql",
			"properties",
			"dockerfile",
			"gitignore",
			"toml",
			"lua",
			-- docs & editor
			"markdown",
			"markdown_inline",
		})
		vim.api.nvim_create_autocmd("FileType", {
			callback = function(args)
				local bufnr = args.buf

				local ok, parser = pcall(vim.treesitter.get_parser, bufnr)
				if not ok or not parser then
					return
				end

				vim.treesitter.start(bufnr)
				vim.bo[bufnr].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})
	end,
}
