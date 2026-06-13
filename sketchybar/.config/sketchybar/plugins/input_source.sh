#!/bin/bash

plist=$(defaults read ~/Library/Preferences/com.apple.HIToolbox.plist AppleSelectedInputSources)

if echo "$plist" | grep -q "com.apple.inputmethod.VietnameseIM"; then
    label="VI"
else
    label="EN"
fi

sketchybar --set "$NAME" label="$label"
