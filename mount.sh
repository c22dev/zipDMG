#!/bin/bash

# Set the URL of the DMG file to download. This is only sample URL
dmg_url="https://github.com/RPCS3/rpcs3-binaries-mac/releases/download/build-3c70573be0b975970d4927734bf4636ad7424805/rpcs3-v0.0.29-15622-3c70573b_macos.dmg"

# Set the output directory where the DMG will be mounted
mount_dir="/Volumes/DMG_Mount"

# Set the name of the output ZIP file
output_zip="output.tar.gz"

# Download the DMG file
echo "Downloading DMG file..."
wget -O "/tmp/file.dmg" "$dmg_url" > /dev/null
# Check if the download was successful
if [ $? -eq 0 ]; then
    # Mount the DMG file
    echo "Mounting DMG file..."
    hdiutil attach "/tmp/file.dmg" -mountpoint "/Volumes/DMG_Mount"

    # Check if the mounting was successful
    if [ $? -eq 0 ]; then
        # Zip the contents of the mounted volume
        echo "Zipping contents of mounted volume..."
        cd "/Volumes/DMG_Mount" || exit
        tar -czf "" . > /dev/null
        tar -czf /tmp/$output_zip . > /dev/null

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
