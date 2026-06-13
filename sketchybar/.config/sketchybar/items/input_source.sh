#!/bin/bash

input_source=(
  update_freq=1
  label.font="$FONT:Bold:14.0"
  script="$PLUGIN_DIR/input_source.sh"
  )

sketchybar --add item input_source right \
           --set input_source "${input_source[@]}"
