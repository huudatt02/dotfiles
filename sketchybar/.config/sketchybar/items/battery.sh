#!/bin/bash

battery=(
  script="$PLUGIN_DIR/battery.sh"
  icon.font="$FONT:Regular:18.0"
  icon="$BATTERY_100"
  label="--%"
  update_freq=120
  updates=on
)

sketchybar --add item battery right      \
           --set battery "${battery[@]}" \
           --subscribe battery power_source_change system_woke
