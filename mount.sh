#!/bin/bash

# Set the URL of the DMG file to download. This is only sample URL
dmg_url="https://sdlc-esd.oracle.com/ESD6/JSCDL/jdk/8u391-b13/b291ca3e0c8548b5a51d5a5f50063037/jre-8u391-macosx-aarch64.dmg?GroupName=JSC&FilePath=/ESD6/JSCDL/jdk/8u391-b13/b291ca3e0c8548b5a51d5a5f50063037/jre-8u391-macosx-aarch64.dmg&BHost=javadl.sun.com&File=jre-8u391-macosx-aarch64.dmg&AuthParam=1700210425_0290996797988298fcd6727d80a4c342&ext=.dmg"
# Set the output directory where the DMG will be mounted
mount_dir="/Volumes/DMG_Mount"

# Set the name of the output AAR file
output_aar="output.aar"

# Download the DMG file
echo "Downloading DMG file..."
wget -O "/tmp/file.dmg" "$dmg_url" > /dev/null
# Check if the download was successful
if [ $? -eq 0 ]; then
    # Mount the DMG file
    echo "Mounting DMG file..."
    yes | hdiutil attach "/tmp/file.dmg" -mountpoint "/Volumes/DMG_Mount"

    # Check if the mounting was successful
    if [ $? -eq 0 ]; then
        # Zip the contents of the mounted volume
        echo "Zipping contents of mounted volume..."
        cd "/Volumes/DMG_Mount" || exit
        rm -f Applications
        aa archive -d . -o /tmp/$output_aar

        # Unmount the DMG file
        echo "Unmounting DMG file..."
        hdiutil detach "/Volumes/DMG_Mount"

        echo "Process completed successfully."
    else
        echo "Error: Failed to mount DMG file."
        exit 1
    fi
else
    echo "Error: Failed to download DMG file."
    exit 1
fi
