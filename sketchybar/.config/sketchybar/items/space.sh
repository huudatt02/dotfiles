#!/bin/bash

sketchybar --add event aerospace_workspace_change

for monitor in $(aerospace list-monitors --format "%{monitor-appkit-nsscreen-screens-id}"); do
  for sid in $(aerospace list-workspaces --monitor "$monitor"); do
    sketchybar --add item space."$sid" left \
      --subscribe space."$sid" aerospace_workspace_change \
      --set space."$sid" \
      background.color=0x44ffffff \
      background.corner_radius=5 \
      background.height=20 \
      background.drawing=off \
      icon="$sid" \
      icon.font="$FONT:Semibold:14.0" \
      label.font="sketchybar-app-font:Regular:16.0" \
      click_script="aerospace workspace $sid" \
      script="$CONFIG_DIR/plugins/space.sh $sid"
  done
done
