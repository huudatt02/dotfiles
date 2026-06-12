#!/bin/sh

plist=$(defaults read ~/Library/Preferences/com.apple.HIToolbox.plist AppleSelectedInputSources)

if echo "$plist" | grep -q "com.apple.inputmethod.VietnameseIM"; then
    icon="VI"
else
    icon="EN"
fi

sketchybar --set "$NAME" icon="$icon"
