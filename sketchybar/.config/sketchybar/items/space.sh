#!/bin/sh

##### Adding Mission Control Space Indicators #####
for monitor in $(aerospace list-monitors --format "%{monitor-appkit-nsscreen-screens-id}"); do
  for sid in $(aerospace list-workspaces --monitor "$monitor" --empty no); do
  done
done
