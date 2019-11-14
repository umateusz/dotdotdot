#!/bin/bash

# Based on: https://raw.githubusercontent.com/tgandor/meats/master/system/add_extra_swap.sh

usage() {
    echo "Usage: $0 [ -f FILEPATH ] [ -s SIZE_IN_GB ]";
}

while getopts ":f::s:" opt; do
    case $opt in
        f) file_path=${OPTARG};;
        s) gb=${OPTARG};;
        :) echo "Missing argument for option -$OPTARG"; usage; exit 1;;
        \?) echo "Unknown option -$OPTARG"; usage; exit 1;;
    esac
done

if [ "$file_path" = "" ] || [ "$gb" = "" ]; then
    usage;
fi

if [[ ! $gb =~ ^[1-9][0-9]*$ ]]; then
    echo "Size must be positive integer.";
    usage;
fi

echo "Creating swap file: $file_path with size: $gb GB";

# this won't work, fails with:
# swapon: /tmp/swapfile: skipping - it appears to have holes.
# sudo dd if=/dev/zero of=$file bs=1G count=0 seek=$gb

echo "Creating $gb GB of zeros in $file_path, please wait..."
sudo dd if=/dev/zero of=$file_path bs=1G count=$gb
sudo chmod 600 $file_path
sudo mkswap $file_path
sudo swapon $file_path

echo "After swapping"
swapon --show
echo "Swappiness: `cat /proc/sys/vm/swappiness`"
