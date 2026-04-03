return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		{
			"fredrikaverpil/neotest-golang",
			version = "*",
		},
	},
	config = function()
		require("neotest").setup({
			adapters = {
				require("neotest-golang")({
					runner = "gotestsum",
				}),
			},
		})
	end,
	-- stylua: ignore start
	keys = {
        { "<leader>tr", function() require("neotest").run.run() end, desc = "Run Nearest (Neotest)" },
        { "<leader>tR", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run File (Neotest)" },
        { "<leader>ts", function() require("neotest").run.stop() end, desc = "Stop (Neotest)" },
        { "<leader>tS", function() require("neotest").summary.toggle() end, desc = "Toggle Summary (Neotest)" },
		{ "<leader>td", function() require("neotest").run.run({ strategy = "dap" }) end, desc = "Debug Nearest" },
        { "<leader>to", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "Show Output (Neotest)" },
	},
	-- stylua: ignore end
}
