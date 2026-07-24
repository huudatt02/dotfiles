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

		if r.windows then
			for _, entry in ipairs(r.windows) do
				open_windows[entry.workspace] = open_windows[entry.workspace] or {}
				table.insert(open_windows[entry.workspace], entry["app-name"])
			end
		end

		local visible_map = {}
		for _, v in ipairs(r.visible or {}) do
			visible_map[v.workspace] = math.floor(v["monitor-appkit-nsscreen-screens-id"])
		end

		f({
			open_windows = open_windows,
			focused_workspace = tonumber(r.focused),
			visible_map = visible_map,
		})
	end)
end

local function buildWorkspace(workspace_index, args)
	local open_windows = args.open_windows[workspace_index] or {}
	local focused = args.focused_workspace
	local is_visible = args.visible_map[workspace_index] ~= nil

	local icons = {}
	local last_app
	local default_icon = app_icons.Default
	for _, app in ipairs(open_windows) do
		if app ~= last_app then
			last_app = app
			icons[#icons + 1] = app_icons[app] or default_icon
		end
	end

	local is_focused = tonumber(workspace_index) == focused

	local config = {
		drawing = true,
		icon = { highlight = is_focused },
		label = { highlight = is_focused, string = "" },
		background = {
			border_width = is_focused and 2 or 0,
			border_color = colors.white,
		},
	}

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
	if old and old.drawing == config.drawing and old.label == config.label.string and old.focused == is_focused then
		return nil
	end

	old = old or {}
	old.drawing = config.drawing
	old.label = config.label.string
	old.focused = is_focused
	last_state[workspace_index] = old

	return config
end

local function updateWorkspaces(on_done)
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

		if on_done then
			on_done(#changed > 0)
		end
	end)
end

local function updateWorkspaceMonitor()
	sbar.exec(query_workspaces, function(workspaces_and_monitors)
		local workspace_monitor = {}
		for _, entry in ipairs(workspaces_and_monitors) do
			workspace_monitor[entry.workspace] = math.floor(entry["monitor-appkit-nsscreen-screens-id"])
		end
		for workspace_index, _ in pairs(workspaces) do
			workspaces[workspace_index]:set({
				display = workspace_monitor[workspace_index] or "active",
			})
		end
	end)
end

sbar.exec(query_workspaces, function(workspaces_and_monitors)
	for _, entry in ipairs(workspaces_and_monitors) do
		local workspace_index = entry.workspace

		local workspace = sbar.add("item", "workspace." .. workspace_index, {
			background = {
				color = colors.with_alpha(colors.bg1, 0.3),
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

	local polls_remaining = 0
	local unchanged_polls = 0
	local debounce_generation = 0
	local poll_generation = 0

	local MAX_POLLS = 5
	local MAX_UNCHANGED_POLLS = 2
	local DEBOUNCE_DELAY = 0.1
	local POLL_INTERVAL = 1

	local function resetPolling()
		polls_remaining = MAX_POLLS
		unchanged_polls = 0
	end

	local function pollWorkspaces(generation)
		if generation ~= poll_generation then
			return
		end

		polls_remaining = polls_remaining - 1

		updateWorkspaces(function(has_changed)
			if generation ~= poll_generation then
				return
			end

			if has_changed then
				unchanged_polls = 0
			else
				unchanged_polls = unchanged_polls + 1
			end

			if polls_remaining <= 0 or unchanged_polls >= MAX_UNCHANGED_POLLS then
				return
			end

			sbar.delay(POLL_INTERVAL, function()
				pollWorkspaces(generation)
			end)
		end)
	end

	local function refreshWorkspaces()
		debounce_generation = debounce_generation + 1
		local generation = debounce_generation

		sbar.delay(DEBOUNCE_DELAY, function()
			if generation ~= debounce_generation then
				return
			end

			poll_generation = poll_generation + 1
			local current_generation = poll_generation
			resetPolling()

			updateWorkspaces(function()
				if current_generation ~= poll_generation then
					return
				end

				sbar.delay(POLL_INTERVAL, function()
					pollWorkspaces(current_generation)
				end)
			end)
		end)
	end

	-- Initial setup
	updateWorkspaceMonitor()
	updateWorkspaces()

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
		updateWorkspaceMonitor()
		refreshWorkspaces()
	end)
end)
