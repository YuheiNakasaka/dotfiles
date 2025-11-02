#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Start QuickTime Player Screen Record
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🤖

# Documentation:
# @raycast.author YuheiNakasaka
# @raycast.authorURL https://raycast.com/YuheiNakasaka

tell application "QuickTime Player"
    activate
    delay 1
    tell application "System Events"
        tell process "QuickTime Player"
            click menu item "新規画面収録" of menu "ファイル" of menu bar 1
        end tell
    end tell
end tell