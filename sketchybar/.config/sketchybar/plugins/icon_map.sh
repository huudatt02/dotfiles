#!/bin/bash

### START-OF-ICON-MAP
function __icon_map() {
    case "$1" in
   "Live")
        icon_result=":ableton:"
        ;;
   "Adobe Bridge"*)
        icon_result=":adobe_bridge:"
        ;;
   "Zulip")
        icon_result=":zulip:"
        ;;
    *)
        icon_result=":default:"
        ;;
    esac
}
### END-OF-ICON-MAP

__icon_map "$1"
echo "$icon_result"
