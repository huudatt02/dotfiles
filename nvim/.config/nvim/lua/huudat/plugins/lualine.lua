return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	dependencies = {
		"nvim-mini/mini.icons",
		"AndreM222/copilot-lualine",
	},
	opts = function()
		local mode = {
			"mode",
			fmt = function(str)
				if vim.fn.winwidth(0) < 100 then
					return str:sub(1, 1)
				end
				return str
			end,
		}

		local branch = { "branch", icon = "" }

		local diagnostics = {
			"diagnostics",
			symbols = { error = " ", warn = " ", info = " ", hint = " " },
			colored = true,
		}

		local diff = {
			"diff",
			symbols = { added = "", modified = "󰜥", removed = "" },
			colored = true,
			diff_color = {
				added = { fg = "#9ece6a" },
				modified = { fg = "#e0af68" },
				removed = { fg = "#f7768e" },
			},
		}

		return {
			options = {
				theme = "tokyonight",
				component_separators = "",
				section_separators = "",
				disabled_filetypes = {},
				globalstatus = false,
			},
			sections = {
				lualine_a = { mode },
				lualine_b = { branch, diff, diagnostics },
				lualine_c = { "filename" },
				lualine_x = { "copilot", "filetype", "encoding" },
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
			extensions = { "fzf", "lazy", "mason", "quickfix", "nvim-dap-ui" },
		}
	end,
}
