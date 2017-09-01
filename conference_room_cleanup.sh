#!/bin/bash

# For conference Macs.
# This script will delete all files in the ~/Desktop, ~/Documents, and ~/Downloads folder
# every Friday night. It will also clear out Safari and Google Chrome cache, cookies, and history.
#
# Schedule to run this every Saturday morning between 12 AM - 2 AM using a cron job.


# Grab the current logged in user
USER=`/bin/ls -la /dev/console | /usr/bin/cut -d " " -f 4`

# Grab the current date
DATE=$(date)

# Output results to a log file
touch /Users/$USER/Library/Logs/conference-room-clean-up.log
exec >/Users/$USER/Library/Logs/conference-room-clean-up.log

echo "$DATE"
echo "Running conference-room-clean-up.sh"
echo "Deleting the contents of ~/Desktop, ~/Documents, and ~/Downloads:"
rm -rfv /Users/$USER/Desktop/*
rm -rfv /Users/$USER/Documents/*
rm -rfv /Users/$USER/Downloads/*


echo "Deleting Chrome cache, cookies, and history."
rm -rf /Users/$USER/Library/Caches/Google/Chrome/Default/Cache/
rm -rf /Users/$USER/Library/Caches/Google/Chrome/Default/Media\ Cache/
rm -rf /Users/$USER/Library/Application\ Support/Google/Chrome/Default/Cookies
rm -rf /Users/$USER/Library/Application\ Support/Google/Chrome/Default/History
