#!/bin/bash

volume=(
  icon="$VOLUME_MEDIUM"
  label="--%"
  label.width=0
  updates=on
  script="$PLUGIN_DIR/volume.sh"
)

sketchybar --add item volume right \
           --set volume "${volume[@]}" \
           --subscribe volume volume_change mouse.clicked
