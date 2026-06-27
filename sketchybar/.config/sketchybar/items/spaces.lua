local colors = require("colors")
local app_icons = require("helpers.app_icons")

local query_workspaces =
	"aerospace list-workspaces --all --format '%{workspace}%{monitor-appkit-nsscreen-screens-id}' --json"
local get_windows = "aerospace list-windows --monitor all --format '%{workspace}%{app-name}%{window-id}' --json"
local query_visible_workspaces =
	"aerospace list-workspaces --visible --monitor all --format '%{workspace}%{monitor-appkit-nsscreen-screens-id}' --json"
local get_focus_workspaces = "aerospace list-workspaces --focused"

local workspaces = {}

local function withWindows(f)
	local results = {
		windows = nil,
		focused = nil,
		visible = nil,
		count = 0,
	}

	local function done()
		if results.count ~= 3 then
			return
		end

		local open_windows = {}
		local processed = {}

		if results.windows then
			for _, entry in ipairs(results.windows) do
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
			focused_workspaces = (results.focused or ""):match("^%s*(.-)%s*$"),
			visible_workspaces = results.visible or {},
		})
	end

	local function set(key, value)
		results[key] = value
		results.count = results.count + 1
		done()
	end

	sbar.exec(get_windows, function(r)
		set("windows", r)
	end)
	sbar.exec(get_focus_workspaces, function(r)
		set("focused", r)
	end)
	sbar.exec(query_visible_workspaces, function(r)
		set("visible", r)
	end)
end

local function updateWindow(workspace_index, args)
	local open_windows = args.open_windows[workspace_index] or {}
	local focused_workspaces = args.focused_workspaces
	local visible_workspaces = args.visible_workspaces

	local icon_line = ""
	local no_app = true
	local rendered_icons = {}

	for _, app in ipairs(open_windows) do
		if not rendered_icons[app] then
			rendered_icons[app] = true
			no_app = false
			local icon = app_icons[app] or app_icons["Default"]
			icon_line = icon_line .. " " .. icon
		end
	end

	local is_focused = (workspace_index == focused_workspaces)

	local config = {
		drawing = true,
		icon = { highlight = is_focused },
		label = { highlight = is_focused, string = icon_line },
		background = {
			border_width = is_focused and 2 or 0,
			border_color = colors.white,
		},
	}

	local is_visible = false
	local visible_monitor_id = nil
	for _, visible_workspace in ipairs(visible_workspaces) do
		if workspace_index == visible_workspace["workspace"] then
			is_visible = true
			visible_monitor_id = math.floor(visible_workspace["monitor-appkit-nsscreen-screens-id"])
			break
		end
	end

	if no_app then
		if is_visible then
			config.label.string = " —"
			config.display = visible_monitor_id
		elseif is_focused then
			config.label.string = " —"
		else
			config.drawing = false
		end
	end

	sbar.animate("tanh", 10, function()
		workspaces[workspace_index]:set(config)
	end)
end

local function updateWindows()
	withWindows(function(args)
		for workspace_index, _ in pairs(workspaces) do
			updateWindow(workspace_index, args)
		end
	end)
end

local function updateWorkspaceMonitor()
	local workspace_monitor = {}
	sbar.exec(query_workspaces, function(workspaces_and_monitors)
		for _, entry in ipairs(workspaces_and_monitors) do
			local space_index = entry.workspace
			local monitor_id = math.floor(entry["monitor-appkit-nsscreen-screens-id"])
			workspace_monitor[space_index] = monitor_id
		end
		for workspace_index, _ in pairs(workspaces) do
			workspaces[workspace_index]:set({
				display = workspace_monitor[workspace_index],
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

	-- Initial setup
	updateWindows()
	updateWorkspaceMonitor()

	local is_polling = false
	local polls_remaining = 0

	local function poll()
		polls_remaining = polls_remaining - 1
		updateWindows()

		if polls_remaining <= 0 then
			is_polling = false
			polls_remaining = 0
			return
		end

		sbar.delay(1, poll)
	end

	local function updateWindowsSmart()
		updateWindows()
		polls_remaining = 5

		if is_polling then
			return
		end

		is_polling = true
		sbar.delay(1, poll)
	end

	-- Event subscription root
	local events = sbar.add("item", "workspace.events", {
		drawing = false,
		updates = true,
	})

	events:subscribe("aerospace_workspace_change", function()
		updateWindowsSmart()
	end)

	events:subscribe("front_app_switched", function()
		updateWindowsSmart()
	end)

	events:subscribe("display_change", function()
		updateWorkspaceMonitor()
		updateWindowsSmart()
	end)
end)
