local icons = require("icons")
local colors = require("colors")

local popup_toggle = "sketchybar --set $NAME popup.drawing=toggle"

local apple_logo = sbar.add("item", {
	padding_right = 15,
	click_script = popup_toggle,
	icon = {
		string = icons.apple,
		font = {
			style = "Black",
			size = 16.0,
		},
		color = colors.green,
	},
	label = {
		drawing = false,
	},
	popup = {
		height = 35,
	},
})

local popup_items = {
	{
		icon = icons.preferences,
		label = "System Settings",
		action = "open -a 'System Settings'",
	},
	{
		icon = icons.activity,
		label = "Activity Monitor",
		action = "open -a 'Activity Monitor'",
	},
	{
		icon = icons.sleep,
		label = "Sleep",
		action = "pmset sleepnow",
	},
	{
		icon = icons.lock,
		label = "Lock Screen",
		action = "pmset displaysleepnow",
	},
	{
		icon = icons.logout,
		label = "Logout",
		action = "osascript -e 'tell application \"System Events\" to log out'",
	},
}

for _, item in ipairs(popup_items) do
	local popup_item = sbar.add("item", {
		position = "popup." .. apple_logo.name,
		icon = item.icon,
		label = item.label,
	})

	popup_item:subscribe("mouse.clicked", function()
		sbar.exec(item.action)
		apple_logo:set({
			popup = {
				drawing = false,
			},
		})
	end)
end
