local icons = require("icons")
local colors = require("colors")

local popup_open = false

local wifi = sbar.add("item", "wifi", {
	position = "right",
	label = {
		drawing = false,
	},
	popup = {
		align = "left",
	},
})

local wifi_toggle = sbar.add("item", "wifi.toggle", {
	position = "popup.wifi",
	icon = {
		string = "Wi-Fi",
		width = 120,
	},
	label = {
		string = "󰔢",
		font = {
			size = 34.0,
		},
		y_offset = 1,
	},
	padding_left = 10,
	padding_right = 10,
})

local wifi_settings = sbar.add("item", "wifi.settings", {
	position = "popup.wifi",
	icon = { string = "Wi-Fi Settings…" },
	label = { drawing = false },
	padding_left = 10,
	padding_right = 10,
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
						padding_left = 6,
						padding_right = 6,
					},
					background = {
						drawing = true,
						color = colors.transparent,
						border_width = 2,
						border_color = colors.white,
						corner_radius = 6,
						height = 18,
						padding_left = 10,
						padding_right = 10,
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
						padding_left = 5,
						padding_right = 5,
					},
				})
			end
		end)
	end)
end

local function update_wifi_toggle()
	sbar.exec("networksetup -getairportpower en0", function(result)
		local is_on = result:match("On")
		wifi_toggle:set({
			label = {
				string = is_on and "󰔡" or "󰔢",
				color = is_on and colors.blue or colors.white,
			},
		})
	end)
end

wifi:subscribe("mouse.clicked", function()
	popup_open = not popup_open
	wifi:set({
		popup = {
			drawing = popup_open,
		},
	})
	if popup_open then
		update_wifi_toggle()
	end
end)

wifi_toggle:subscribe("mouse.clicked", function()
	sbar.exec("networksetup -getairportpower en0", function(result)
		local is_on = result:match("On")
		sbar.exec("networksetup -setairportpower en0 " .. (is_on and "off" or "on"), function()
			update_wifi_toggle()
			update_wifi()
		end)
	end)
end)

wifi_settings:subscribe("mouse.clicked", function()
	sbar.exec("open 'x-apple.systempreferences:com.apple.wifi-settings'")
	popup_open = false
	wifi:set({ popup = { drawing = false } })
end)

wifi:subscribe({ "wifi_change", "system_woke" }, update_wifi)
