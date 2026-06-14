#!/bin/bash

volume=(
  script="$PLUGIN_DIR/volume.sh"
  icon="$VOLUME_MEDIUM"
  label="--%"
  updates=on
)

sketchybar --add item volume right \
           --set volume "${volume[@]}" \
           --subscribe volume volume_change
