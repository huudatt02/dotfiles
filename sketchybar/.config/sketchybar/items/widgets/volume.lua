local icons = require("icons")
local colors = require("colors")

local volume = sbar.add("item", "volume", {
	position = "right",
	icon = {
		font = {
			style = "Regular",
			size = 16.0,
		},
	},
	label = {
		width = 0,
		string = "--%",
		font = {
			style = "Semibold",
			size = 14.0,
		},
	},
	popup = {
		align = "center",
		horizontal = true,
	},
	updates = true,
})

local STEP = 10

local volume_icon_low = sbar.add("item", "volume.icon.low", {
	position = "popup." .. volume.name,
	icon = { drawing = false },
	label = {
		string = icons.volume._10,
		font = {
			family = icons.font,
			size = 14.0,
		},
		color = colors.white,
	},
	padding_left = 10,
	padding_right = 0,
})

local volume_slider = sbar.add("slider", "volume.slider", 120, {
	position = "popup." .. volume.name,
	slider = {
		highlight_color = colors.blue,
		background = {
			height = 6,
			corner_radius = 3,
			color = colors.bg2,
		},
		knob = {
			string = "􀀁",
			drawing = true,
		},
	},
	background = { drawing = false },
	padding_left = 0,
	padding_right = 0,
})

local volume_icon_high = sbar.add("item", "volume.icon.high", {
	position = "popup." .. volume.name,
	icon = { drawing = false },
	label = {
		string = icons.volume._100,
		font = {
			family = icons.font,
			size = 14.0,
		},
		color = colors.white,
	},
	padding_left = 0,
	padding_right = 10,
})

local hide_id = 0
local label_visible = false
local label_pinned = false
local current_volume = 0

local function open_label()
	if label_visible then
		return
	end
	label_visible = true
	sbar.animate("tanh", 20, function()
		volume:set({ label = { width = 42 } })
	end)
end

local function close_label()
	if not label_visible then
		return
	end
	label_visible = false
	sbar.animate("tanh", 20, function()
		volume:set({ label = { width = 0 } })
	end)
end

local function show_label_temporarily()
	if label_pinned then
		return
	end
	hide_id = hide_id + 1
	local current_id = hide_id
	open_label()
	sbar.exec("sleep 2", function()
		if current_id ~= hide_id then
			return
		end
		if not label_pinned then
			close_label()
		end
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

local function set_volume(v, skip_slider, temporary)
	if not v then
		return
	end
	current_volume = v
	volume:set({
		icon = { string = icon_for_volume(v) },
		label = { string = ("%d%%"):format(v) },
	})
	if not skip_slider then
		volume_slider:set({ slider = { percentage = v } })
	end
	if temporary then
		show_label_temporarily()
	end
end

local function apply_volume(v)
	v = math.max(0, math.min(100, v))
	sbar.exec(("osascript -e 'set volume output volume %d'"):format(v))
	set_volume(v, false, true)
end

local function update_volume(env)
	set_volume(tonumber(env.INFO), false, true)
end

local function show_current_volume()
	sbar.exec("osascript -e 'output volume of (get volume settings)'", function(output)
		set_volume(tonumber(output), false, false)
	end)
end

volume:subscribe("mouse.clicked", function()
	hide_id = hide_id + 1
	show_current_volume()
	label_pinned = not label_pinned
	if label_pinned then
		open_label()
	else
		close_label()
	end
	volume:set({ popup = { drawing = "toggle" } })
end)

volume_slider:subscribe("mouse.clicked", function(env)
	local percentage = math.floor(tonumber(env.PERCENTAGE) + 0.5)
	apply_volume(percentage)
end)

volume_icon_low:subscribe("mouse.clicked", function()
	apply_volume(current_volume - STEP)
end)

volume_icon_high:subscribe("mouse.clicked", function()
	apply_volume(current_volume + STEP)
end)

volume:subscribe("volume_change", update_volume)
