#!/bin/bash

# This script uses MySides to setup the preferences for Finder

# ***** Variables *****
user=`ls -la /dev/console | cut -d " " -f 4`
home_dir="/Users/$user"
finder_setup_done="$home_dir/.findersetupdone"
log_file="$home_dir/Library/Logs/finder_setup.log"
mysides="/usr/local/bin/mysides"

#---Redirect output to a log file---#
exec >> $log_file 2>&1

# ----------------------------
# ***** Install  MySides *****
# ----------------------------

# Check if MySides is installed. If not, install it!
if [ -x $mysides ]; then

	echo "mysides is installed"

else

	echo "mysides is NOT installed. Downloading tool from Github."

	# Create temp directory
	mkdir /tmp/mysides

	# Download mysides from Github and place it in the temp directory
	curl -L0k https://github.com/mosen/mysides/releases/download/v1.0.1/mysides-1.0.1.pkg -o /tmp/mysides/mysides.pkg

	# Install downloaded .pkg
	sudo installer -pkg /tmp/mysides/mysides.pkg -target /

fi

sleep 2

# ----------------------------
# *****FINDER PREFERENCES*****
# ----------------------------

# Finder setup function
finder_preferences_setup(){

# Close System Preferences if it's open
sudo -u $user osascript -e 'tell application "System Preferences" to quit'

# Show icons for hard drives, servers, and removable media on the desktop
sudo -u $user defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
sudo -u $user defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
sudo -u $user defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
sudo -u $user defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# New Finder window opens Home directory
sudo -u $user defaults write com.apple.finder NewWindowTarget -string "PfHm"
sudo -u $user defaults write com.apple.finder NewWindowTargetPath -string "file://$user/"

# Finder: show all filename extensions
sudo -u $user defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Finder: show status bar
sudo -u $user defaults write com.apple.finder ShowStatusBar -bool true

# Finder: show path bar
sudo -u $user defaults write com.apple.finder ShowPathbar -bool true

# When performing a search, search the current folder by default
sudo -u $user defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Use list view in all Finder windows by default
# Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`
sudo -u $user defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Show the ~/Library folder
sudo -u $user chflags nohidden ~/Library

# Disable "Back to my Mac" and "Bonjour Computers"
touch /Users/$user/.sidebarshortcuts
/usr/libexec/PlistBuddy -c "Add :networkbrowser:CustomListProperties:com.apple.NetworkBrowser.backToMyMacEnabled bool False" /Users/$user/Library/Preferences/com.apple.sidebarlists.plist
/usr/libexec/PlistBuddy -c "Add :networkbrowser:CustomListProperties:com.apple.NetworkBrowser.bonjourEnabled bool False" /Users/$user/Library/Preferences/com.apple.sidebarlists.plist

# Finder: Add home folder to the top of the sidebar
sudo -u $user $mysides remove Applications file:///Applications
sudo -u $user $mysides remove Desktop file:///Users/$user/Desktop
sudo -u $user $mysides remove Documents file:///Users/$user/Documents
sudo -u $user $mysides remove Downloads file:///Users/$user/Downloads
sudo -u $user $mysides add $user file:///Users/$user
sudo -u $user $mysides add Applications file:///Applications
sudo -u $user $mysides add Desktop file:///Users/$user/Desktop
sudo -u $user $mysides add Documents file:///Users/$user/Documents
sudo -u $user $mysides add Downloads file:///Users/$user/Downloads


# Use mysides to remove All My Files, iCloud, and AirDrop from sidebar
sudo -u $user $mysides remove All\ My\ Files file:///System/Library/CoreServices/Finder.app/Contents/Resources/MyLibraries/myDocuments.cannedSearch/ && sleep 2
sudo -u $user $mysides remove domain-AirDrop && sleep 2

# Restart Finder
killall Finder

# iCloud Drive
sudo -u $user $mysides remove iCloud Drive file:///Users/$user/iCloud Drive && sleep 2

killall Finder

# Create .findersetupdone file so Finder setup will not run again
touch $finder_setup_done
}

if [ ! -f $finder_setup_done ]; then        # Check if the dock setup script has been run before
    echo "Running finder_preferences_setup"
    finder_preferences_setup
fi
