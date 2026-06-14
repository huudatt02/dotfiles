#!/bin/bash

source "$CONFIG_DIR/icons.sh"

wifi=(
  label.drawing=off
  icon="$WIFI_DISCONNECTED"
  script="$PLUGIN_DIR/wifi.sh"
)

sketchybar --add item wifi right \
           --set wifi "${wifi[@]}" \
           --subscribe wifi wifi_change
