local icons = require("icons")

local apple_logo = sbar.add("item", "apple", {
	icon = {
		string = icons.apple,
		font = {
			style = "Regular",
			size = 18.0,
		},
	},
	label = {
		drawing = false,
	},
	popup = {
		align = "left",
	},
})

local popup_items = {
	{
		name = "settings",
		icon = icons.gear,
		label = "System Settings",
		action = "open -a 'System Settings'",
	},
	{
		name = "activity_monitor",
		icon = icons.chart,
		label = "Activity Monitor",
		action = "open -a 'Activity Monitor'",
	},
	{
		name = "sleep",
		icon = icons.sleep,
		label = "Sleep",
		action = "pmset sleepnow",
	},
	{
		name = "lock",
		icon = icons.lock,
		label = "Lock Screen",
		action = "pmset displaysleepnow",
	},
	{
		name = "logout",
		icon = icons.user,
		label = "Logout",
		action = "osascript -e 'tell application \"System Events\" to log out'",
	},
}

apple_logo:subscribe("mouse.clicked", function()
	apple_logo:set({
		popup = {
			drawing = "toggle",
		},
	})
end)

for _, item in ipairs(popup_items) do
	local popup_item = sbar.add("item", "apple." .. item.name, {
		position = "popup." .. apple_logo.name,
		icon = {
			string = item.icon,
			width = 30,
			align = "left",
		},
		label = item.label,
		padding_left = 10,
		padding_right = 10,
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
