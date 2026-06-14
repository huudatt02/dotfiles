#!/bin/bash

### START-OF-ICON-MAP
function icon_map() {
  case "$1" in
  "Alacritty")
    icon_result=":alacritty:"
    ;;
  "Android Studio")
    icon_result=":android_studio:"
    ;;
  "App Store")
    icon_result=":app_store:"
    ;;
  "Brave Browser")
    icon_result=":brave_browser:"
    ;;
  "Calendar")
    icon_result=":calendar:"
    ;;
  "Chromium" | "Google Chrome" | "Google Chrome Canary")
    icon_result=":google_chrome:"
    ;;
  "Calculator")
    icon_result=":calculator:"
    ;;
  "DataGrip")
    icon_result=":datagrip:"
    ;;
  "FaceTime")
    icon_result=":face_time:"
    ;;
  "Finder")
    icon_result=":finder:"
    ;;
  "Firefox Developer Edition" | "Firefox Nightly")
    icon_result=":firefox_developer_edition:"
    ;;
  "Firefox")
    icon_result=":firefox:"
    ;;
  "GoLand")
    icon_result=":goland:"
    ;;
  "IntelliJ IDEA")
    icon_result=":idea:"
    ;;
  "iTerm" | "iTerm2")
    icon_result=":iterm:"
    ;;
  "kitty")
    icon_result=":kitty:"
    ;;
  "Maps" | "Google Maps")
    icon_result=":maps:"
    ;;
  "Mail")
    icon_result=":mail:"
    ;;
  "Messages")
    icon_result=":messages:"
    ;;
  "MongoDB Compass"*)
    icon_result=":mongodb:"
    ;;
  "Music")
    icon_result=":music:"
    ;;
  "Notes")
    icon_result=":notes:"
    ;;
  "Podcasts")
    icon_result=":podcasts:"
    ;;
  "PhpStorm")
    icon_result=":php_storm:"
    ;;
  "PyCharm")
    icon_result=":pycharm:"
    ;;
  "Reminders")
    icon_result=":reminders:"
    ;;
  "Rider" | "JetBrains Rider")
    icon_result=":rider:"
    ;;
  "Safari")
    icon_result=":safari:"
    ;;
  "Sequel Ace")
    icon_result=":sequel_ace:"
    ;;
  "Sequel Pro")
    icon_result=":sequel_pro:"
    ;;
  "SF Symbols")
    icon_result=":sf_symbols:"
    ;;
  "Spotify")
    icon_result=":spotify:"
    ;;
  "Spotlight")
    icon_result=":spotlight:"
    ;;
  "System Preferences" | "System Settings")
    icon_result=":gear:"
    ;;
  "Terminal")
    icon_result=":terminal:"
    ;;
  "VSCodium")
    icon_result=":vscodium:"
    ;;
  "WezTerm")
    icon_result=":wezterm:"
    ;;
  "WebStorm")
    icon_result=":web_storm:"
    ;;
  "Xcode")
    icon_result=":xcode:"
    ;;
  "Zed")
    icon_result=":zed:"
    ;;
  "Zen Browser")
    icon_result=":zen_browser:"
    ;;
  *)
    icon_result=":default:"
    ;;
  esac
}

### END-OF-ICON-MAP

icon_map "$1"
echo "$icon_result"
