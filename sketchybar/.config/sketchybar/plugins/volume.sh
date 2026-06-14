#!/bin/sh

source "$CONFIG_DIR/icons.sh"

show_label() {
  sketchybar --set "$NAME" label.drawing=on

  (
    sleep 2
    sketchybar --set "$NAME" label.drawing=off
  ) &
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
