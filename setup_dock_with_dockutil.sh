#!/bin/bash

# This script uses Dockutil to setup the Mac OS dock configured for our imaged Macs.
# It checks if specific apps are installed, and if so, add it to the dock.
# Should be used with a launch agent so the script can run at login.

#---Check if dockutil is installed---#
if [ -x "/usr/local/bin/dockutil" ]; then

	echo "dockutil is installed"

else

	echo "dockutil is NOT installed. Downloading tool from Github."

	# Create temp directory
	mkdir /tmp/dockutil

	# Download Dockutil from Github and place it in the temp directory
	curl -L0k https://github.com/kcrawford/dockutil/releases/download/2.0.5/dockutil-2.0.5.pkg -o /tmp/dockutil/dockutil.pkg

	# Install downloaded .pkg
	installer -pkg /tmp/dockutil/dockutil.pkg -target /

fi

#---Variables---#
logged_in_user=`/usr/bin/stat -f%Su /dev/console`
home_dir="/Users/$logged_in_user"
dock_setup_done="$home_dir/.docksetupdone"
log_file="$home_dir/Library/Logs/dock_setup.log"
os_vers=`sw_vers -productVersion | awk -F "." '{print $2}'`
dockutil="/usr/local/bin/dockutil"

#---Redirect output to a log file---#
exec >> $log_file 2>&1

# Dock set up function
initial_dock_setup(){

	# removes all items from the Dock and restarts

	echo "Clearing the dock..."
	$dockutil --remove all $home_dir

	sleep 3 # Give computer time to remove apps from the dock

	echo "Adding apps to the dock..."

	$dockutil --add '/Applications/System Preferences.app'  --no-restart $home_dir

	if [[ -d "/Applications/Self Service.app" ]]; then
		$dockutil --add '/Applications/Self Service.app' --no-restart $home_dir
	else
		echo "Self Service not installed"
	fi

	$dockutil --add '/Applications/App Store.app'  --no-restart $home_dir

	if [[ -d "/Applications/Google Chrome.app" ]]; then
		$dockutil --add '/Applications/Google Chrome.app' --no-restart $home_dir
	else
		echo "Google Chrome not installed"
	fi

	if [[ -d "/Applications/Blue Jeans.app" ]]; then
		$dockutil --add '/Applications/Blue Jeans.app' --no-restart $home_dir
	else
		echo "Blue Jeans not installed"
	fi

	if [[ -d "/Applications/Keynote.app" ]]; then
		$dockutil --add '/Applications/Keynote.app' --no-restart $home_dir
	else
		echo "Keynote not installed"
	fi

	if [[ -d "/Applications/Microsoft Excel.app" ]]; then
		$dockutil --add '/Applications/Microsoft Excel.app' --no-restart $home_dir
	else
		echo "Excel not installed"
	fi

	if [[ -d "/Applications/Microsoft Word.app" ]]; then
		$dockutil --add '/Applications/Microsoft Word.app' --no-restart $home_dir
	else
		echo "Word not installed"
	fi

	if [[ -d "/Applications/Slack.app" ]]; then
		$dockutil --add '/Applications/Slack.app' --no-restart $home_dir
	else
		echo "Slack not installed"
	fi

	if [[ -d "/Applications/PluralEyes 4.app" ]]; then
		$dockutil --add '/Applications/PluralEyes 4.app' --no-restart $home_dir
	else
		echo "PluralEyes not installed"
	fi

	# ---------------- Adobe CC 2015.3 -----------------------------

	if [[ -d "/Applications/Adobe Photoshop CC 2015.5/Adobe Photoshop CC 2015.5.app" ]]; then
		$dockutil --add '/Applications/Adobe Photoshop CC 2015.5/Adobe Photoshop CC 2015.5.app' --no-restart $home_dir
	else
		echo "Photoshop CC 2015.5 not installed"
	fi

	if [[ -d "/Applications/Adobe Illustrator CC 2015.3/Adobe Illustrator CC 2015.3.app" ]]; then
		$dockutil --add '/Applications/Adobe Illustrator CC 2015.3/Adobe Illustrator CC 2015.3.app' --no-restart $home_dir
	else
		echo "Adobe Illustrator CC not installed"
	fi

	if [[ -d "/Applications/Adobe Premiere Pro CC 2015.3/Adobe Premiere Pro CC 2015.app" ]]; then
		$dockutil --add '/Applications/Adobe Premiere Pro CC 2015.3/Adobe Premiere Pro CC 2015.app' --no-restart $home_dir
	else
		echo "Adobe Premiere Pro CC 2015 not installed"
	fi

	if [[ -d "/Applications/Adobe After Effects CC 2015.3/Adobe After Effects CC 2015.app" ]]; then
		$dockutil --add '/Applications/Adobe After Effects CC 2015.3/Adobe After Effects CC 2015.app' --no-restart $home_dir
	else
		echo "Adobe After Effects CC 2015 not installed"
	fi

	# ---------------- Adobe CC 2017 -----------------------------

	if [[ -d "/Applications/Adobe Photoshop CC 2017/Adobe Photoshop CC 2017.app" ]]; then
		$dockutil --add '/Applications/Adobe Photoshop CC 2017/Adobe Photoshop CC 2017.app' --no-restart $home_dir
	else
		echo "Photoshop CC 2017 not installed"
	fi

	if [[ -d "/Applications/Adobe Illustrator CC 2017/Adobe Illustrator CC 2017.app" ]]; then
		$dockutil --add '/Applications/Adobe Illustrator CC 2017/Adobe Illustrator CC 2017.app' --no-restart $home_dir
	else
		echo "Adobe Illustrator CC 2017 not installed"
	fi

	if [[ -d "/Applications/Adobe Premiere Pro CC 2017/Adobe Premiere Pro CC 2017.app" ]]; then
		$dockutil --add '/Applications/Adobe Premiere Pro CC 2017/Adobe Premiere Pro CC 2017.app' --no-restart $home_dir
	else
		echo "Adobe Premiere Pro CC 2017 not installed"
	fi

	if [[ -d "/Applications/Adobe After Effects CC 2017/Adobe After Effects CC 2017.app" ]]; then
		$dockutil --add '/Applications/Adobe After Effects CC 2017/Adobe After Effects CC 2017.app' --no-restart $home_dir
	else
		echo "Adobe After Effects CC 2017 not installed"
	fi

	#Finishing with the Downloads folder on the right (restarts to set the Dock)
	$dockutil --add '~/Downloads' --view fan --display folder $home_dir

	# Create .docksetupdone file so dock is not re-created
	touch $dock_setup_done
}


if [ ! -f $dock_setup_done ]; then        # Check if the dock setup script has been run before
    echo "Running initial_dock_setup"
    initial_dock_setup
fi
