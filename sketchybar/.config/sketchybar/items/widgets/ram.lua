local icons = require("icons")

local ram = sbar.add("item", "widgets.ram", {
	position = "right",
	update_freq = 2,
	icon = {
		string = icons.ram,
		font = {
			style = "Bold",
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

ram:subscribe({ "routine", "forced" }, function(env)
	sbar.exec("vm_stat", function(output)
		local function pages(name)
			return tonumber(output:match(name .. ":%s+(%d+)"))
		end

		local pages_free = pages("Pages free")
		local pages_active = pages("Pages active")
		local pages_inactive = pages("Pages inactive")
		local pages_wired = pages("Pages wired down")
		local pages_speculative = pages("Pages speculative") or 0
		local pages_occupied = pages("Pages occupied by compressor") or 0

		if pages_free and pages_active and pages_inactive and pages_wired then
			local total_pages = pages_free
				+ pages_active
				+ pages_inactive
				+ pages_speculative
				+ pages_wired
				+ pages_occupied
			local used_pages = pages_active + pages_wired + pages_occupied
			local usage_percent = math.floor((used_pages / total_pages) * 100)

			ram:set({
				label = { string = usage_percent .. "%" },
			})
		end
	end)
end)
