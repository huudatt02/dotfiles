local icons = require("icons")

sbar.exec("killall cpu_load >/dev/null; $CONFIG_DIR/helpers/event_providers/cpu_load/bin/cpu_load cpu_update 2.0")

local cpu = sbar.add("item", "widgets.cpu", 42, {
	position = "right",
	icon = {
		string = icons.cpu,
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

cpu:subscribe("cpu_update", function(env)
	local load = tonumber(env.total_load)
	cpu:push({ load / 100. })

	cpu:set({
		label = load .. "%",
	})
end)
