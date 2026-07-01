local input_source = sbar.add("item", "input_source", {
	position = "right",
	icon = {
		font = {
			style = "Bold",
			size = 14.0,
		},
	},
	label = {
		drawing = false,
	},
})

local function update_input_source()
	sbar.exec("macism", function(source)
		source = source:gsub("%s+$", "")

		input_source:set({
			icon = source:find("Vietnamese") and "VI" or "EN",
		})
	end)
end

sbar.add("event", "input_source_change", "AppleSelectedInputSourcesChangedNotification")

input_source:subscribe("input_source_change", update_input_source)

update_input_source()
