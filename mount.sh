#!/bin/bash

# Set the URL of the DMG file to download. This is only sample URL
dmg_url="https://d3jdrrl94b667u.cloudfront.net/Raycast_v1.62.2_130f04282e8fd59a05082658c1c483b1af1da006_universal.dmg?response-content-disposition=attachment%3B%20filename%3DRaycast.dmg&Expires=1701096248&Signature=FZ5UQCqc5v~7gaHmEWK2mzdm8n9ii8iH4dWon73f2JlhpDPJF-jqC-jJy7hQRgzbx2KGc5xjOGcY1RQ-w5Gpf7dK-PXAysVv-oc4sxeEG85Ae7759iOwQ3gRYGksu-5i~36NBJ1Se8ErIVvs5WWWU1FcrbuEqD-rlaIITRyH6tTEuiCiyf0Ko5pBG-HDaRp~y9PZRuEXhjOyptCfTyfKbdv1qbSgY6tSZdDDEZENFA3l5VLe8ddINZQY5CrQQG~R002vYGUD1lWHNKvR4Wo2mDm0qAPm9i1c6djdHDGCFHY-Z85Fhimzd4g7uOgXfVKsT412lwx8osArHni4DSWIbg__&Key-Pair-Id=K69CUC23G592W"
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
