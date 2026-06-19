local icons = require("icons")

local volume = sbar.add("item", "volume", {
	position = "right",

	icon = {
		string = icons.volume.medium,
	},

	label = {
		string = "--%",
		width = 0,
		font = {
			style = "Semibold",
			size = 14.0,
		},
	},

	updates = true,
})

local hide_id = 0
local label_visible = false

local function show_label()
	hide_id = hide_id + 1
	local current_id = hide_id

	if not label_visible then
		label_visible = true

		sbar.animate("tanh", 20, function()
			volume:set({
				label = {
					width = 42,
				},
			})
		end)
	end

	sbar.exec("sleep 2", function()
		if current_id ~= hide_id then
			return
		end

		label_visible = false

		sbar.animate("tanh", 20, function()
			volume:set({
				label = {
					width = 0,
				},
			})
		end)
	end)
end

local function icon_for_volume(v)
	if v == 0 then
		return icons.volume._0
	elseif v <= 20 then
		return icons.volume._10
	elseif v <= 40 then
		return icons.volume._33
	elseif v <= 70 then
		return icons.volume._66
	else
		return icons.volume._100
	end
end

local function update_volume(env)
	local v = tonumber(env.INFO)

	if not v then
		return
	end

	volume:set({
		icon = {
			string = icon_for_volume(v),
		},

		label = {
			string = ("%d%%"):format(v),
		},
	})

	show_label()
end

volume:subscribe("volume_change", update_volume)

volume:subscribe("mouse.clicked", function()
	sbar.exec("osascript -e 'output volume of (get volume settings)'", function(output)
		local v = tonumber(output)

		if not v then
			return
		end

		volume:set({
			icon = {
				string = icon_for_volume(v),
			},

			label = {
				string = ("%d%%"):format(v),
			},
		})

		show_label()
	end)
end)
