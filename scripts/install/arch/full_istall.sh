#!/bin/bash

# Internet connectivity is assumed.

sudo echo "Starting..."

TARGET_DISK=${1}
if [ -z "${TARGET_DISK}" ]; then
    echo
    echo "Target disk for installation. Typically 'sda'."
    read -p "TARGET_DISK: " TARGET_DISK
fi

lsblk /dev/$TARGET_DISK

