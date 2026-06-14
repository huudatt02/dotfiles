#!/bin/sh

source "$CONFIG_DIR/icons.sh"

show_label() {
  PID_FILE="/tmp/sketchybar-volume.pid"

  [ -f "$PID_FILE" ] &&
    kill "$(cat "$PID_FILE")" 2>/dev/null

  WIDTH=$(sketchybar --query "$NAME" | jq -r '.label.width')

  if [ "$WIDTH" -eq 0 ]; then
    sketchybar --animate tanh 20 --set "$NAME" label.width=42
  else
    sketchybar --set "$NAME" label.width=42
  fi

  (
    sleep 2
    sketchybar --animate tanh 20 --set "$NAME" label.width=0
  ) &

  echo $! > "$PID_FILE"
}

case "$SENDER" in
  "volume_change")
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

    sketchybar --set "$NAME" \
      icon="$ICON" \
      label="${VOLUME}%"

    show_label
    ;;

  "mouse.clicked")
    VOLUME="$(osascript -e 'output volume of (get volume settings)')"

    sketchybar --set "$NAME" label="${VOLUME}%"

    show_label
    ;;
esac
