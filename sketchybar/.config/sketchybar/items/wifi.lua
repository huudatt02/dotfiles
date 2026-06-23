local icons = require("icons")
local colors = require("colors")

local wifi = sbar.add("item", "wifi", {
	position = "right",
	label = {
		drawing = false,
	},
})

local function update_wifi()
	sbar.exec("ipconfig getifaddr en0 2>/dev/null", function(output)
		local connected = output and output:match("%S")

		sbar.exec("scutil --nwi | grep -m1 'utun'", function(vpn_output)
			local vpn_connected = vpn_output and vpn_output:match("utun")

			if vpn_connected then
				wifi:set({
					icon = {
						string = "VPN",
						font = {
							style = "Bold",
							size = 10.0,
						},
					},
					background = {
						drawing = true,
						color = colors.transparent,
						border_width = 1,
						border_color = colors.white,
						corner_radius = 5,
						height = 18,
					},
				})
			else
				wifi:set({
					icon = {
						string = connected and icons.wifi.connected or icons.wifi.disconnected,
						font = {
							style = "Regular",
							size = 16.0,
						},
					},
					background = {
						drawing = false,
					},
				})
			end
		end)
	end)
end

wifi:subscribe({ "wifi_change", "system_woke" }, update_wifi)
