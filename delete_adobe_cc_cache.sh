#!/bin/bash

# This script will clear out the cache from Adobe CC directories

# Grab current logged in user
currentUser=`ls -l /dev/console | awk '{ print $3 }'`

# Iterate through each file in the specific directories and delete it
echo "Deleting all contents from ~/Library/Caches/Adobe/After\ Effects/"
for f in /Users/$currentUser/Library/Caches/Adobe/After\ Effects/*; do rm -rf "$f"; done

echo "Deleting all contents from ~/Library/Application\ Support/Adobe/Common/Media\ Cache\ Files/"
for f in /Users/$currentUser/Library/Application\ Support/Adobe/Common/Media\ Cache\ Files/*; do rm -rf "$f"; done

echo "Deleting all contents from ~/Library/Application\ Support/Adobe/Common/Media\ Cache/"
for f in /Users/$currentUser/Library/Application\ Support/Adobe/Common/Media\ Cache/*; do rm -rf "$f"; done
