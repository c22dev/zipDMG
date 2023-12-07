#!/bin/bash

# Set the URL of the DMG file to download. This is only sample URL
dmg_url="https://d3jdrrl94b667u.cloudfront.net/Raycast_v1.63.0_99d08db6535e02fba414449d0cf97b2edbd22dd0_universal.dmg?response-content-disposition=attachment%3B%20filename%3DRaycast.dmg&Expires=1701957372&Signature=a4f9KtUqcLOZBaUZq-vE6dg~2kaYt5veWy0sv~uO7SknJVELkE2tgoVV1VbGDeewslbFHeWp79UNYs2UU8wO1SoML9GfWW4OYY5CUBEMvWtpaIgC1gU-tk956tRhBMYTI~C1qPKY2SmxMCDP0iTgFRNs-1L5FdgZ6528Llc23NmnDVB0nPQaXlq6V2m4yzJiJ01J2Ak7Hwo4cu-rY-zq3oMvWGvNYVzwncxnAZ~K9pW8tCHf9n3P7L-Xk5CIFMkbZHjEmARuoH4eXhDaFkHIHPbc0p4uINo72l9uCCSwq~6P7Taw-~Z1JZu9kawq6kDZbbZsS8BhDW-kc2u~COpnUA__&Key-Pair-Id=K69CUC23G592W"
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
