# JAMF-Scripts

This repository is a collection of bash scripts that are used to manage macOS devices. These scripts were deployed and executed by JAMF Pro, however most of these scripts should still work by themselves.

## autohide_dock.sh

Sets the dock to automatically hide. It will also remove the delay if you mouse over the dock so it will show immediately.

## check_bluetooth_battery_levels.sh

Checks the battery levels on the connected Magic Keyboard 2 and Magic Trackpad 2. If the battery levels are less than or equal to 20%, it will send an email notification.

This was used in an workplace that used Mac Minis in each conference room. We had the script send an email to our IT help desk team so they can make sure the bluetooth peripherals had sufficient battery life.

It is best to use this script with a cron job to check the battery levels every 2 hours and during business hours.

## conference-room-clean-up.sh

This script cleaned up our conference room Mac Minis. Since some employees would login to Google Chrome or download attachments on these conference room devices, this script will delete files from commonly used directories. It will also clear the cache, cookies, and history in Google Chrome.

Should be used with a cron job at least once a day.

Cleans up the following directories:
* ~/Desktop
* ~/Documents
* ~/Downloads
* ~/Library/Caches/Google/Chrome/Default/Cache
* ~/Library/Caches/Google/Chrome/Default/Media\ Cache/
* ~/Library/Application\ Support/Google/Chrome/Default/Cookies
* ~/Library/Application\ Support/Google/Chrome/Default/History

## curl_and_install_zipped_app.sh

Downloads and installs a zipped application silently in the background.

## get_git_version.sh

Checks if the device has Apple's version of Git installed. It does this by checking if X-Code command line tools are installed first. If the command line tools are installed, then it will return the Git version.

This is meant to be used with JAMF Pro's extension attributes.

## install_printer_template.sh

Installs and configures a printer on the network.

## instal_recommended_macos_updates.sh

Checks if the device has any recommended macOS updates and installs them.

## set_macos_desktop_background.sh

Sets the desktop background on a user account that is not Administrator.

## setup_dock_with_dockutil.sh

Downloads and installs [Dockutil](https://github.com/kcrawford/dockutil) to customize the macOS dock with the desired applications.

## setup_finder_prefs.sh

Sets the following Finder preferences:
* Shows icons for hard drives, servers, and removable media on the Desktop
* Set the Home folder as the default folder when opening Finder
* Show all filename extensions
* Show the status bar
* Show the path bar
* Search the current folder by default
* Use the list view by default
* Reveal the ~/Library folder
* Disable "Back to my Mac" and "Bonjour Computers"
* Downloads and installs [MySides](https://github.com/mosen/mysides) to customize the folders on the sidebar
* Uses MySides to remove "All My Files", "iCloud Drive", and "AirDrop" from the sidebar
