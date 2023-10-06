#!/bin/bash

# Set the URL of the DMG file to download. This is only sample URL
dmg_url="https://aio-fowntain.koyeb.app/uv/service/hvtrs8%2F-saoltgnv-kaf3%2F1%2Cxz.dbadl.lev%2Ft%2Fv3%3B.36790-4%2F30202020%5D2%3A11275%3B8373677%5D940%3B2081164%3B001%3A55_l.fme%2FUhctqArp%2F2%2C21.39%2C84.fme%3F%5Dna_aav%3D312%26ac%60%3D3-5%26%5Dna_qif%3D22483a%24_lc%5Dojc%3FLLD35%5DG%2FU1sCX%3BrEG%60s%24_lc%5Dhv%3Dqcmnvelt%2Ficd1-3.zx%24oj%3D20%5DAdDl_CC0RoZFVkHQpodsDA_PV%2Fx%3AZi9FzzTRL6c0OFXZHe%26me%3F67270CF5"

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
