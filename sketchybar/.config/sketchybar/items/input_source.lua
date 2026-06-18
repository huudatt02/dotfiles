local input_source = sbar.add("item", {
	position = "right",
	label = {
		font = {
			style = "Bold",
			size = 14.0,
		},
	},
})

local function update_input_source()
	sbar.exec(
		"defaults read com.apple.HIToolbox AppleSelectedInputSources",
		function(plist)
			input_source:set({
				label = plist:find("VietnameseIM") and "VI" or "EN",
			})
		end
	)
end

sbar.add("event", "input_source_change", "AppleSelectedInputSourcesChangedNotification")

input_source:subscribe("input_source_change", update_input_source)

update_input_source()
