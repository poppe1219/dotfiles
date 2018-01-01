#!/usr/bin/env python3

import subprocess


def run_stuff():
    disk = input('Disk name, typically "sda"? ')
    output = subprocess.check_output(['sudo', 'fdisk', '-l', '/dev/{}'.format(disk)])
    print(output.decode())
    output = subprocess.check_output(['sudo', 'ls', '-la'])
    print(output.decode())
    #with open('command.log', 'a') as log_file: 
    #    log_file.write(output.decode())
    #    log_file.close()
    print("Done.")


if __name__ == "__main__":
    #var1 = run_script_1()
    #var2 = run_script_2(var1)
    #var3 = run_script_3(var2)
    run_stuff()


"""
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
"""
