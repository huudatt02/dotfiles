local icons = require("icons")

local cal = sbar.add("item", {
	position = "right",
	icon = {
		string = icons.calendar,
		font = {
			style = "Regular",
			size = 16.0,
		},
	},
	label = {
		align = "right",
		font = {
			style = "Semibold",
			size = 14.0,
		},
	},
	update_freq = 30,
	click_script = "open -a 'Calendar'",
})

local function update_calendar()
	cal:set({
		label = {
			string = os.date("%a %d %b %H:%M"),
		},
	})
end

cal:subscribe({ "forced", "routine", "system_woke" }, update_calendar)
