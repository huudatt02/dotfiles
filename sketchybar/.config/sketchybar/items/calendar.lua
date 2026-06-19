local settings = require("settings")
local colors = require("colors")

local cal = sbar.add("item", {
	icon = {
		color = colors.system.white,
		font = {
			style = settings.font.style_map["Semibold"],
			size = 14.0,
		},
	},
	label = {
		color = colors.system.white,
		width = 45,
		align = "right",
		font = {
			family = settings.font.numbers,
			style = settings.font.style_map["Semibold"],
			size = 14.0,
		},
	},
	position = "right",
	update_freq = 30,
  click_script = "open -a 'Calendar'"
})

cal:subscribe({ "forced", "routine", "system_woke" }, function(env)
  cal:set({ icon = os.date("%a %d %b"), label = os.date("%H:%M") })
end)
