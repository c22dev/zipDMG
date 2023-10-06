#!/bin/bash

# Set the URL of the DMG file to download. This is only sample URL
dmg_url="https://cloud.bluestacks.com/api/getdownloadnow?platform=mac&win_version=&mac_version=10.15.7&client_uuid=7cf2c2ec-ea55-4a2b-afb9-adddf7ac8b31&app_pkg=com.robtopx.geometrydashsubzero&platform_cloud=&preferred_lang=en&utm_source=&utm_medium=&gaCookie=GA1.1.954550162.1696614023&gclid=&clickid=&msclkid=&affiliateId=&offerId=&transaction_id=&aff_sub=&first_landing_page=https%253A%252F%252Fwww.bluestacks.com%252Fapps%252Farcade%252Fgeometry-dash-subzero-on-pc.html&referrer=https%253A%252F%252Fduckduckgo.com%252F&download_page_referrer=&utm_campaign=ap-geometry-dash-subzero-us&user_id=&exit_utm_campaign=ap-geometry-dash-subzero-us&incompatible=false&bluestacks_version=bs5&device_memory=undefined&device_cpu_cores=8"

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
