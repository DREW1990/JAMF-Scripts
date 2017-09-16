# JAMF-Scripts

This repository is a collection of bash scripts that are used to manage macOS devices. These scripts were deployed and executed by JAMF Pro, however most of these scripts should still work by themselves.

## autohide_dock.sh

Sets the dock to automatically hide. It will also remove the delay if you mouse over the dock so it will show immediately.

## check_bluetooth_battery_levels.sh

Checks the battery levels on the connected Magic Keyboard 2 and Magic Trackpad 2. If the battery levels are less than or equal to 20%, it will send an email notification.

This was used in an workplace that used Mac Minis in each conference room. We had the script send an email to our IT help desk team so they can make sure the bluetooth peripherals had sufficient battery life.

It is best to use this script with a cron job to check the battery levels every 2 hours and during business hours.
