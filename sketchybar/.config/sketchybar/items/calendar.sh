#!/bin/bash

calendar=(
  icon=􀉉
  update_freq=10
  script="$PLUGIN_DIR/calendar.sh"
)

sketchybar --add item calendar right \
           --set calendar "${calendar[@]}"
