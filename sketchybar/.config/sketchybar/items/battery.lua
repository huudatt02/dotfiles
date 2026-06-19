local icons = require("icons")

local battery = sbar.add("item", {
	position = "right",
	icon = {
		string = icons.battery._100,
		font = {
			style = "Regular",
			size = 19.0,
		},
	},
	label = {
		string = "--%",
		font = {
			style = "Semibold",
			size = 14.0,
		},
	},
	update_freq = 120,
})

local function battery_update()
	sbar.exec("pmset -g batt", function(batt_info)
		local icon = "!"
		local percentage = ""

		local found, _, charge = batt_info:find("(%d+)%%")
		if found then
			percentage = charge .. "%"
			charge = tonumber(charge)
		end

		if string.find(batt_info, "AC Power") then
			icon = icons.battery.charging
		elseif charge > 80 then
			icon = icons.battery._100
		elseif charge > 60 then
			icon = icons.battery._75
		elseif charge > 40 then
			icon = icons.battery._50
		elseif charge > 20 then
			icon = icons.battery._25
		else
			icon = icons.battery._0
		end

		battery:set({
			icon = icon,
			label = percentage,
		})
	end)
end

battery:subscribe({ "routine", "power_source_change", "system_woke" }, battery_update)
