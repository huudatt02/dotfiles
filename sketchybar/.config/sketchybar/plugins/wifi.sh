#!/bin/bash

source "$CONFIG_DIR/icons.sh"

IP="$(ipconfig getifaddr en0 2>/dev/null)"
ICON="$([ -n "$IP" ] && echo "$WIFI_CONNECTED" || echo "$WIFI_DISCONNECTED")"

sketchybar --set "$NAME" icon="$ICON"
