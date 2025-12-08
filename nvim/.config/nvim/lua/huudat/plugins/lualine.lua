return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
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

		local filename = {
			"filename",
			path = 1,
			fmt = function(name)
				if vim.fn.winwidth(0) < 100 then
					return vim.fn.fnamemodify(name, ":t")
				end

				local parts = vim.split(name, "/")
				local len = #parts
				if len <= 3 then
					return name
				else
					return table.concat({ parts[len - 2], parts[len - 1], parts[len] }, "/")
				end
			end,
		}

		local branch = { "branch", icon = "" }

		local diagnostics = {
			"diagnostics",
			symbols = { error = "󰅙 ", warn = "󰀦 ", info = "󰋼 ", hint = "󰠠 " },
			colored = true,
		}

		local diff = {
			"diff",
			symbols = { added = "󰐕", modified = "󰜥", removed = "󰅖" },
			colored = true,
			diff_color = {
				added = { fg = "#9ece6a" },
				modified = { fg = "#e0af68" },
				removed = { fg = "#f7768e" },
			},
		}

		local function filesize()
			if vim.fn.winwidth(0) < 80 then
				return ""
			end

			local size = math.max(vim.fn.line2byte(vim.fn.line("$") + 1) - 1, 0)
			if size < 1024 then
				return string.format("%dB", size)
			elseif size < 1048576 then
				return string.format("%.2fKiB", size / 1024)
			else
				return string.format("%.2fMiB", size / 1048576)
			end
		end

		return {
			options = {
				theme = "tokyonight",
				component_separators = "",
				section_separators = "",
				disabled_filetypes = { "undotree", "diff" },
			},
			sections = {
				lualine_a = { mode },
				lualine_b = { branch, diff, diagnostics },
				lualine_c = { filename },
				lualine_x = { "filetype", filesize, "encoding" },
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
			extensions = { "quickfix", "nvim-dap-ui", "fzf", "lazy", "mason" },
		}
	end,
}
