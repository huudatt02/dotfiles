sbar.add("item", "chevron", {
	position = "left",
	background = {
		drawing = false,
	},
	icon = {
		string = "􀆊",
		font = {
			style = "Bold",
			size = 16,
		},
	},
	label = {
		drawing = false,
	},
})

local front_app = sbar.add("item", "front_app", {
	position = "left",
	display = "active",
	icon = {
		background = {
			drawing = true,
		},
	},
	label = {
		font = {
			style = "Bold",
			size = 14,
		},
	},
	click_script = "open -a 'Mission Control'",
})

front_app:subscribe("front_app_switched", function(env)
	local app = env.INFO

	front_app:set({
		label = app,

		icon = {
			background = {
				image = {
					string = "app." .. app,
					scale = 0.8,
				},
			},
		},
	})
end)
