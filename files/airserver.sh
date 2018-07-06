#!/bin/bash
# this checks to see if files created by Airserver's first run exist on a user account. 
# if not, it will launch Airserver

if ! test -f ~/Library/Preferences/com.pratikkumar.airserver-mac.plist; then /Applications/AirServer.app/Contents/MacOS/AirServer 
fi
