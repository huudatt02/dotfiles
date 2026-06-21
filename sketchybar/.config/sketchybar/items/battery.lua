local icons = require("icons")
local colors = require("colors")

local battery = sbar.add("item", {
	position = "right",
	icon = {
		font = {
			style = "Regular",
			size = 19.0,
		},
	},
	label = {
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
		local icon_color = colors.system.white

		local found, _, charge = batt_info:find("(%d+)%%")
		if found then
			percentage = charge .. "%"
			charge = tonumber(charge)
		end

		if string.find(batt_info, "AC Power") then
			icon = icons.battery.charging
			icon_color = colors.system.green
		elseif charge > 80 then
			icon = icons.battery._100
		elseif charge > 60 then
			icon = icons.battery._75
		elseif charge > 40 then
			icon = icons.battery._50
		elseif charge > 20 then
			icon = icons.battery._25
			icon_color = colors.system.yellow
		else
			icon = icons.battery._0
			icon_color = colors.system.red
		end

		battery:set({
			icon = {
				string = icon,
				color = icon_color,
			},
			label = percentage,
		})
	end)
end

battery:subscribe({ "routine", "power_source_change", "system_woke" }, battery_update)
