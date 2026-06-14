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
  "Code" | "Code - Insiders")
    icon_result=":code:"
    ;;
  "Cursor")
    icon_result=":cursor:"
    ;;
  "DataGrip")
    icon_result=":datagrip:"
    ;;
  "DataSpell")
    icon_result=":dataspell:"
    ;;
  "Discord" | "Discord Canary" | "Discord PTB")
    icon_result=":discord:"
    ;;
  "Docker" | "Docker Desktop")
    icon_result=":docker:"
    ;;
  "Drafts")
    icon_result=":drafts:"
    ;;
  "draw.io")
    icon_result=":draw_io:"
    ;;
  "FaceTime")
    icon_result=":face_time:"
    ;;
  "Figma")
    icon_result=":figma:"
    ;;
  "Final Cut Pro")
    icon_result=":final_cut_pro:"
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
  "GitHub Desktop")
    icon_result=":git_hub:"
    ;;
  "GoLand")
    icon_result=":goland:"
    ;;
  "IINA")
    icon_result=":iina:"
    ;;
  "Insomnia")
    icon_result=":insomnia:"
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
  "LM Studio")
    icon_result=":lm_studio:"
    ;;
  "MAMP" | "MAMP PRO")
    icon_result=":mamp:"
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
  "Neovide" | "neovide")
    icon_result=":neovide:"
    ;;
  "Neovim" | "neovim" | "nvim")
    icon_result=":neovim:"
    ;;
  "Notes")
    icon_result=":notes:"
    ;;
  "Obsidian")
    icon_result=":obsidian:"
    ;;
  "OBS")
    icon_result=":obsstudio:"
    ;;
  "Preview")
    icon_result=":pdf:"
    ;;
  "Podcasts")
    icon_result=":podcasts:"
    ;;
  "Postman")
    icon_result=":postman:"
    ;;
  "PhpStorm")
    icon_result=":php_storm:"
    ;;
  "PyCharm")
    icon_result=":pycharm:"
    ;;
  "qutebrowser")
    icon_result=":qute_browser:"
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
  "Telegram")
    icon_result=":telegram:"
    ;;
  "Terminal")
    icon_result=":terminal:"
    ;;
  "Trello")
    icon_result=":trello:"
    ;;
  "VMware Fusion")
    icon_result=":vmware_fusion:"
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
  "zoom.us")
    icon_result=":zoom:"
    ;;
  *)
    icon_result=":default:"
    ;;
  esac
}
### END-OF-ICON-MAP

icon_map "$1"
echo "$icon_result"
