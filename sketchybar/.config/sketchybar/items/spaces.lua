local colors = require("colors")
local app_icons = require("helpers.app_icons")

local query_workspaces =
	"aerospace list-workspaces --all --format '%{workspace}%{monitor-appkit-nsscreen-screens-id}' --json"

local query_all = [[sh -c '
windows=$(aerospace list-windows --monitor all --format "%{workspace}%{app-name}%{window-id}" --json)
focused=$(aerospace list-workspaces --focused)
visible=$(aerospace list-workspaces --visible --monitor all --format "%{workspace}%{monitor-appkit-nsscreen-screens-id}" --json)
printf "{\"windows\":%s,\"focused\":\"%s\",\"visible\":%s}" "$windows" "$focused" "$visible"
']]

local workspaces = {}
local last_state = {}

local function fetchAerospace(f)
	sbar.exec(query_all, function(r)
		if not r then
			return
		end

		local open_windows = {}
		local processed = {}

		if r.windows then
			for _, entry in ipairs(r.windows) do
				local wid = entry["window-id"]
				if not processed[wid] then
					processed[wid] = true
					open_windows[entry.workspace] = open_windows[entry.workspace] or {}
					table.insert(open_windows[entry.workspace], entry["app-name"])
				end
			end
		end

		f({
			open_windows = open_windows,
			focused_workspaces = tonumber((r.focused or ""):match("^%s*(.-)%s*$")),
			visible_workspaces = r.visible or {},
		})
	end)
end

local function buildWorkspace(workspace_index, args)
	local open_windows = args.open_windows[workspace_index] or {}
	local visible_workspaces = args.visible_workspaces
	local focused = args.focused_workspaces
	local visible_map = args._visible_map
	if not visible_map then
		visible_map = {}
		for i = 1, #visible_workspaces do
			local v = visible_workspaces[i]
			visible_map[v.workspace] = math.floor(v["monitor-appkit-nsscreen-screens-id"])
		end
		args._visible_map = visible_map
	end

	local icons = {}
	local rendered_icons = {}
	for i = 1, #open_windows do
		local app = open_windows[i]
		if not rendered_icons[app] then
			rendered_icons[app] = true
			icons[#icons + 1] = app_icons[app] or app_icons.Default
		end
	end

	local is_focused = tonumber(workspace_index) == focused
	local raw_monitor_id = visible_map[workspace_index]
	local is_visible = raw_monitor_id ~= nil

	local config = {
		drawing = true,
		icon = { highlight = is_focused },
		label = { highlight = is_focused, string = "" },
		background = {
			border_width = is_focused and 2 or 0,
			border_color = colors.white,
		},
	}

	if raw_monitor_id then
		config.display = raw_monitor_id
	end

	if #icons > 0 then
		config.label.string = " " .. table.concat(icons, " ")
	else
		if not is_visible and not is_focused then
			config.drawing = false
		else
			config.label.string = " —"
		end
	end

	local old = last_state[workspace_index]
	if
		old
		and old.drawing == config.drawing
		and old.label == config.label.string
		and old.focused == is_focused
		and old.display == raw_monitor_id
	then
		return nil
	end

	old = old or {}
	old.drawing = config.drawing
	old.label = config.label.string
	old.focused = is_focused
	old.display = raw_monitor_id
	last_state[workspace_index] = old

	return config
end

local function updateWorkspaces()
	fetchAerospace(function(args)
		local changed = {}
		for workspace_index in pairs(workspaces) do
			local config = buildWorkspace(workspace_index, args)
			if config then
				changed[#changed + 1] = { workspace_index, config }
			end
		end

		if #changed > 0 then
			sbar.animate("tanh", 10, function()
				for _, entry in ipairs(changed) do
					local workspace_index, config = entry[1], entry[2]
					workspaces[workspace_index]:set(config)
				end
			end)
		end
	end)
end

sbar.exec(query_workspaces, function(workspaces_and_monitors)
	for _, entry in ipairs(workspaces_and_monitors) do
		local workspace_index = entry.workspace

		local workspace = sbar.add("item", "workspace." .. workspace_index, {
			background = {
				color = colors.with_alpha(colors.bg, 0.3),
				drawing = true,
			},
			click_script = "aerospace workspace " .. workspace_index,
			drawing = false,
			icon = {
				color = colors.with_alpha(colors.white, 0.3),
				drawing = true,
				font = {
					style = "Semibold",
					size = 16.0,
				},
				highlight_color = colors.white,
				padding_left = 10,
				padding_right = 0,
				string = workspace_index,
			},
			label = {
				color = colors.with_alpha(colors.white, 0.3),
				drawing = true,
				font = "sketchybar-app-font:Regular:16.0",
				highlight_color = colors.white,
				padding_left = 5,
				padding_right = 15,
				y_offset = -1,
			},
		})

		workspaces[workspace_index] = workspace
	end

	sbar.add("item", "chevron", {
		position = "left",
		display = "active",
		background = { drawing = false },
		icon = {
			string = "􀆊",
			font = { style = "Bold", size = 16.0 },
		},
		label = { drawing = false },
	})

	local front_app = sbar.add("item", "front_app", {
		position = "left",
		display = "active",
		icon = { background = { drawing = true } },
		label = { font = { style = "Bold", size = 14.0 } },
		click_script = "open -a 'Mission Control'",
	})

	front_app:subscribe("front_app_switched", function(env)
		local app = env.INFO
		front_app:set({
			label = app,
			icon = {
				background = {
					image = {
						string = "app." .. app,
						scale = 0.8,
					},
				},
			},
		})
	end)

	-- Initial setup
	updateWorkspaces()

	local is_polling = false
	local polls_remaining = 0

	local function pollWorkspaces()
		polls_remaining = polls_remaining - 1
		updateWorkspaces()

		if polls_remaining <= 0 then
			is_polling = false
			polls_remaining = 0
			return
		end

		sbar.delay(1, pollWorkspaces)
	end

	local function refreshWorkspaces()
		updateWorkspaces()
		polls_remaining = 3

		if is_polling then
			return
		end

		is_polling = true
		sbar.delay(1, pollWorkspaces)
	end

	-- Event subscription root
	local events = sbar.add("item", "workspace.events", {
		drawing = false,
		updates = true,
	})

	events:subscribe("aerospace_workspace_change", function()
		refreshWorkspaces()
	end)

	events:subscribe("front_app_switched", function()
		refreshWorkspaces()
	end)

	events:subscribe("display_change", function()
		refreshWorkspaces()
	end)
end)
