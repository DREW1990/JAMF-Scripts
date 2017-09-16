# JAMF-Scripts

This repository is a collection of bash scripts that are used to manage macOS devices. These scripts were deployed and executed by JAMF Pro, however most of these scripts should still work by themselves.

## autohide_dock.sh

Sets the dock to automatically hide. It will also remove the delay if you mouse over the dock so it will show immediately.

## check_bluetooth_battery_levels.sh

Checks the battery levels on the connected Magic Keyboard 2 and Magic Trackpad 2. If the battery levels are less than or equal to 20%, it will send an email notification.

This was used in an workplace that has a Mac Mini in each conference room. It helped us make sure the bluetooth peripherals were not dead and to send us reminders that they needed to be charged.

It is best to use this script with a cron job to check the battery levels every 2 hours.
