return {
	"karb94/neoscroll.nvim",
	event = "VeryLazy",
	opts = {
		hide_cursor = false,
		stop_eof = true,
		respect_scrolloff = false,
		cursor_scrolls_alone = true,
		duration_multiplier = 1.0,
		easing = "linear",
		pre_hook = nil,
		post_hook = nil,
		performance_mode = false,
		ignored_events = {
			"WinScrolled",
			"CursorMoved",
		},
	},
	config = function(_, opts)
		local neoscroll = require("neoscroll")
		neoscroll.setup(opts)

		local keymap = {
			["<C-u>"] = function()
				neoscroll.ctrl_u({ duration = 250 })
			end,
			["<C-d>"] = function()
				neoscroll.ctrl_d({ duration = 250 })
			end,
			["<C-b>"] = function()
				neoscroll.ctrl_b({ duration = 450 })
			end,
			["<C-f>"] = function()
				neoscroll.ctrl_f({ duration = 450 })
			end,
			["<C-y>"] = function()
				neoscroll.scroll(-0.1, { move_cursor = false, duration = 100 })
			end,
			["<C-e>"] = function()
				neoscroll.scroll(0.1, { move_cursor = false, duration = 100 })
			end,
			["zt"] = function()
				neoscroll.zt({ half_win_duration = 250 })
			end,
			["zz"] = function()
				neoscroll.zz({ half_win_duration = 250 })
			end,
			["zb"] = function()
				neoscroll.zb({ half_win_duration = 250 })
			end,
		}
		local modes = { "n", "v", "x" }
		for key, func in pairs(keymap) do
			vim.keymap.set(modes, key, func)
		end
	end,
}
