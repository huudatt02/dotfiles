local cal = sbar.add("item", {
	icon = {
		font = {
			style = "Semibold",
			size = 14.0,
		},
	},
	label = {
		width = 45,
		align = "right",
		font = {
			style = "Semibold",
			size = 14.0,
		},
	},
	position = "right",
	update_freq = 30,
	click_script = "open -a 'Calendar'",
})

cal:subscribe({ "forced", "routine", "system_woke" }, function(env)
	cal:set({ icon = os.date("%a %d %b"), label = os.date("%H:%M") })
end)
