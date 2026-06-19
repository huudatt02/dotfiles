local icons = require("icons")

local volume = sbar.add("item", "volume", {
  position = "right",

  icon = {
    string = icons.volume.medium,
  },

  label = {
    string = "--%",
    width = 0,
  },

  updates = true,
})

local hide_id = 0

local function show_label()
  hide_id = hide_id + 1
  local current_id = hide_id

  local width = tonumber(volume:query().label.width) or 0

  if width == 0 then
    sbar.animate("tanh", 20, function()
      volume:set({
        label = {
          width = 42,
        },
      })
    end)
  else
    volume:set({
      label = {
        width = 42,
      },
    })
  end

  sbar.exec("sleep 2", function()
    if current_id ~= hide_id then
      return
    end

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
    return icons.volume.mute
  elseif v <= 20 then
    return icons.volume.min
  elseif v <= 40 then
    return icons.volume.low
  elseif v <= 70 then
    return icons.volume.medium
  else
    return icons.volume.high
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
  sbar.exec(
    "osascript -e 'output volume of (get volume settings)'",
    function(output)
      local v = tonumber(output)

      if not v then
        return
      end

      volume:set({
        label = {
          string = ("%d%%"):format(v),
        },
      })

      show_label()
    end
  )
end)
