#!/bin/sh

if [ "$SENDER" = "volume_change" ]; then
  VOLUME="$INFO"

  case "$VOLUME" in
    [5-9][1-9]|100) ICON="􀊩" ;;
    50) ICON="􀊥" ;;
    [1-4][0-9]) ICON="􀊥" ;;
    *) ICON="󰖁" ;;
  esac

  sketchybar --set "$NAME" icon="$ICON" label="$VOLUME%"
fi
