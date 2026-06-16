#!/bin/bash

sketchybar --add event aerospace_workspace_change

for monitor in $(aerospace list-monitors --format "%{monitor-appkit-nsscreen-screens-id}"); do
  for sid in $(aerospace list-workspaces --monitor "$monitor" --empty no); do
  done
done
