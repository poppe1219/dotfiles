#!/usr/bin/env python3

import subprocess


def run_stuff():
    disk = input('Disk name, typically "sda"? ')
    # Lets try the new Python3 approach, run().
    completed = subprocess.run(
        ['sudo', 'fdisk', '-l', '/dev/{}'.format(disk)],
        encoding="utf-8",
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE
    )
    if completed.returncode == 0:
        print('Success!')
        output = completed.stdout
        print("Len of output: {}".format(len(output)))
        print('STDOUT: {}'.format(output))
    else:
        print('Fail!')
        print('Returncode: {}'.format(completed.returncode))
        output2 = completed.stderr
        print('STDERR: {}'.format(output2))
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
