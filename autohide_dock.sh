#!/bin/bash

# This script will auto hide the dock and set it to delay to 0 ms

# Grab current logged in user
USER=`/bin/ls -la /dev/console | /usr/bin/cut -d " " -f 4`

# Autohide dock
sudo -u $USER defaults write com.apple.dock autohide -bool true

# Set delay to 0 ms
sudo -u $USER defaults write com.apple.Dock autohide-delay -float 0

# Kill Dock and reopen
killall Dock
