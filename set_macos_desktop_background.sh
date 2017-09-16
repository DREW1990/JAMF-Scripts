#!/bin/bash

# Changes the desktop background for MacOS computers.

# Grab the current logged in user
logged_in_user=`ls -la /dev/console | cut -d " " -f 4`

# Path to desktop background
desktop_bg = '/path/to/desktop/background'

# If the logged in user is not admin, change the background.
if [ $logged_in_user == "admin" ]; then

  echo "Run this policy on user other than Administrator."

  exit 1

else

  # Set the specific background
  sudo -u $logged_in_user /usr/bin/osascript -e 'tell application "Finder" to set desktop picture to POSIX file "$desktop_bg"'

fi
