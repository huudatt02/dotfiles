#!/bin/sh

source "$CONFIG_DIR/icons.sh"

if [ "$SENDER" = "volume_change" ]; then
  VOLUME="$INFO"

  if [ "$VOLUME" -eq 0 ]; then
    ICON="$VOLUME_MUTE"
  elif [ "$VOLUME" -le 20 ]; then
    ICON="$VOLUME_MIN"
  elif [ "$VOLUME" -le 40 ]; then
    ICON="$VOLUME_LOW"
  elif [ "$VOLUME" -le 70 ]; then
    ICON="$VOLUME_MEDIUM"
  else
    ICON="$VOLUME_HIGH"
  fi

  sketchybar --set "$NAME" icon="$ICON" label="${VOLUME}%"
fi
