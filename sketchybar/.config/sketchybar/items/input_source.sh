#!/bin/bash

input_source=(
  label.font="$FONT:Bold:14.0"
  update_freq=1
  script="$PLUGIN_DIR/input_source.sh"
)

sketchybar --add event input_source_change 'AppleSelectedInputSourcesChangedNotification' \
           --add item input_source right \
           --set input_source "${input_source[@]}" \
           --subscribe input_source input_source_change
