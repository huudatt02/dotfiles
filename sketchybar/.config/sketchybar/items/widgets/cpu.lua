local icons = require("icons")

sbar.exec("killall cpu_load >/dev/null; $CONFIG_DIR/helpers/event_providers/cpu_load/bin/cpu_load cpu_update 2.0")

local cpu = sbar.add("item", "widgets.cpu", {
	position = "right",
	popup = {
		align = "left",
	},
	icon = {
		string = icons.cpu,
		font = {
			style = "Semibold",
			size = 16.0,
		},
	},
	label = {
		string = "--%",
	},
})

local user = sbar.add("item", "cpu.user", {
	position = "popup.widgets.cpu",
	icon = {
		string = "User",
		width = 80,
		font = {
			style = "Semibold",
			size = 14.0,
		},
	},
	label = "--%",
	padding_left = 10,
	padding_right = 10,
})

local sys = sbar.add("item", "cpu.sys", {
	position = "popup.widgets.cpu",
	icon = {
		string = "System",
		width = 80,
		font = {
			style = "Semibold",
			size = 14.0,
		},
	},
	label = "--%",
	padding_left = 10,
	padding_right = 10,
})

cpu:subscribe("cpu_update", function(env)
	local total = tonumber(env.total_load) or 0
	local user_load = tonumber(env.user_load) or 0
	local sys_load = tonumber(env.sys_load) or 0

	cpu:push({ total / 100 })

	cpu:set({
		label = total .. "%",
	})

	user:set({
		label = user_load .. "%",
	})

	sys:set({
		label = sys_load .. "%",
	})
end)

cpu:subscribe("mouse.clicked", function()
	cpu:set({
		popup = {
			drawing = "toggle",
		},
	})
end)
