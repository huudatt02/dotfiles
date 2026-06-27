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

local function withWindows(f)
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
			focused_workspaces = (r.focused or ""):match("^%s*(.-)%s*$"),
			visible_workspaces = r.visible or {},
		})
	end)
end

local rendered_icons = {}

local function updateWindow(workspace_index, args)
	local open_windows = args.open_windows[workspace_index] or {}
	local visible_workspaces = args.visible_workspaces

	local focused = args.focused_workspaces
	focused = focused and focused:match("^%s*(.-)%s*$")
	focused = tonumber(focused)

	local visible_map = args._visible_map
	if not visible_map then
		visible_map = {}
		for i = 1, #visible_workspaces do
			local v = visible_workspaces[i]
			visible_map[v.workspace] = math.floor(v["monitor-appkit-nsscreen-screens-id"])
		end
		args._visible_map = visible_map
	end

	for k in pairs(rendered_icons) do
		rendered_icons[k] = nil
	end

	local icons = {}

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
		label = {
			highlight = is_focused,
			string = "",
		},
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
			if raw_monitor_id then
				config.display = raw_monitor_id
			end
		end
	end

	sbar.animate("tanh", 10, function()
		workspaces[workspace_index]:set(config)
	end)
end

local function updateWindows()
	local function render(args)
		for workspace_index in pairs(workspaces) do
			updateWindow(workspace_index, args)
		end
	end

	withWindows(render)
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
		polls_remaining = 3

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
