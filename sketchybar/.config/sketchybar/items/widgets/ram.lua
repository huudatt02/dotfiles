local icons = require("icons")

local ram = sbar.add("item", "widgets.ram", {
	position = "right",
	update_freq = 2,
	popup = {
		align = "left",
	},
	icon = {
		string = icons.ram,
		font = {
			style = "Semibold",
			size = 16.0,
		},
	},
	label = {
		string = "--%",
		font = {
			style = "Semibold",
			size = 14.0,
		},
	},
})

local memory_used = sbar.add("item", "widgets.ram.used", {
	position = "popup.widgets.ram",
	icon = {
		string = "Used",
		width = 80,
		font = {
			style = "Semibold",
			size = 14.0,
		},
	},
	label = {
		string = "-- GB",
	},
	padding_left = 10,
	padding_right = 10,
})

local cached = sbar.add("item", "widgets.ram.cached", {
	position = "popup.widgets.ram",
	icon = {
		string = "Cached",
		width = 80,
		font = {
			style = "Semibold",
			size = 14.0,
		},
	},
	label = "-- GB",
	padding_left = 10,
	padding_right = 10,
})

ram:subscribe({ "routine", "forced" }, function()
	sbar.exec("vm_stat", function(output)
		local function pages(name)
			return tonumber(output:match(name .. ":%s+(%d+)"))
		end

		local page_size = tonumber(output:match("page size of (%d+) bytes")) or 4096

		local pages_free = pages("Pages free")
		local pages_active = pages("Pages active")
		local pages_inactive = pages("Pages inactive")
		local pages_wired = pages("Pages wired down")
		local pages_speculative = pages("Pages speculative") or 0
		local pages_compressed = pages("Pages occupied by compressor") or 0

		if pages_free and pages_active and pages_inactive and pages_wired then
			local total_pages = pages_free
				+ pages_active
				+ pages_inactive
				+ pages_speculative
				+ pages_wired
				+ pages_compressed

			local used_pages = pages_active + pages_wired + pages_compressed
			local cached_pages = pages_inactive + pages_speculative

			local usage_percent = math.floor(used_pages / total_pages * 100)
			local used_gb = used_pages * page_size / 1024 ^ 3
			local cached_gb = cached_pages * page_size / 1024 ^ 3

			ram:set({
				label = usage_percent .. "%",
			})

			memory_used:set({
				label = string.format("%.2f GB", used_gb),
			})

			cached:set({
				label = string.format("%.2f GB", cached_gb),
			})
		end
	end)
end)

ram:subscribe("mouse.clicked", function()
	ram:set({
		popup = {
			drawing = "toggle",
		},
	})
end)
