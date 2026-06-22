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

		sbar.exec("scutil --nwi | grep -m1 'utun'", function(vpn_output)
			local vpn_connected = vpn_output and vpn_output:match("utun")

			local icon = nil

			if vpn_connected then
				icon = icons.vpn.connected
			else
				icon = connected and icons.wifi.connected or icons.wifi.disconnected
			end

			wifi:set({
				icon = {
					string = icon,
				},
			})
		end)
	end)
end

wifi:subscribe({ "wifi_change", "system_woke" }, update_wifi)
