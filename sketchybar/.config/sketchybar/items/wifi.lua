local icons = require("icons")

local wifi = sbar.add("item", "wifi", {
	position = "right",
	icon = {
		font = {
			style = "Regular",
			size = 16.0,
		},
	},
	label = {
		drawing = false,
	},
})

local function update_wifi()
	sbar.exec("ipconfig getifaddr en0 2>/dev/null", function(output)
		local connected = output and output:match("%S")

		wifi:set({
			icon = {
				string = connected and icons.wifi.connected or icons.wifi.disconnected,
			},
		})
	end)
end

wifi:subscribe({ "wifi_change", "system_woke" }, update_wifi)
