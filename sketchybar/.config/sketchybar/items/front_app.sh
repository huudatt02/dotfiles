#!/bin/bash

chevron=(
  background.drawing=off
  icon=􀆊
  icon.font="SF Pro:Bold:16.0"
  label.drawing=off
)

front_app=(
  display=active
  icon.background.drawing=on
  label.font="$FONT:Bold:14.0"
  script="$PLUGIN_DIR/front_app.sh"
  click_script="open -a 'Mission Control'"
)

sketchybar --add item chevron left \
           --set chevron "${chevron[@]}"

sketchybar --add item front_app left \
           --set front_app "${front_app[@]}" \
           --subscribe front_app front_app_switched
