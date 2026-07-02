local popup_open = false

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
	popup = {
		align = "left",
	},
})

local en = sbar.add("item", "input_source.en", {
	position = "popup.input_source",
	icon = { width = 20 },
	label = {
		string = "ABC",
	},
	padding_left = 10,
	padding_right = 10,
})

local vi = sbar.add("item", "input_source.vi", {
	position = "popup.input_source",
	icon = { width = 20 },
	label = {
		string = "Vietnamese Telex",
	},
	padding_left = 10,
	padding_right = 10,
})

local function update_input_source()
	sbar.exec("macism", function(source)
		source = source:gsub("%s+$", "")

		local is_vi = source:find("Vietnamese")

		input_source:set({
			icon = is_vi and "VI" or "EN",
		})

		en:set({
			icon = {
				string = is_vi and "" or "✓",
			},
		})

		vi:set({
			icon = {
				string = is_vi and "✓" or "",
			},
		})
	end)
end

sbar.add("event", "input_source_change", "AppleSelectedInputSourcesChangedNotification")

input_source:subscribe("input_source_change", update_input_source)

input_source:subscribe("mouse.clicked", function()
	popup_open = not popup_open
	input_source:set({
		popup = {
			drawing = popup_open,
		},
	})
end)

en:subscribe("mouse.clicked", function()
	sbar.exec("macism com.apple.keylayout.ABC")
	input_source:set({ popup = { drawing = false } })
	popup_open = false
end)

vi:subscribe("mouse.clicked", function()
	sbar.exec("macism com.apple.inputmethod.VietnameseIM.VietnameseSimpleTelex")
	input_source:set({ popup = { drawing = false } })
	popup_open = false
end)

update_input_source()
