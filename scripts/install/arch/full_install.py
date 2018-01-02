#!/usr/bin/env python3

import sys
import subprocess


"""
Swap partition size:
If ram is less than 1GB:
    swap = ram * 2
else:
    min sqrt(ram)
    max ram x 2


Partitioning example of 10GB
sda1, 8MB, BIOS Boot
sda2, 500M, Linux filesystem.
sda3, 3G, Linux filesystem.
sda4, 6.5, Linux filesystem.
sync

Format:
mkfs.ext4 /dev/sda2
mkfs.ext4 /dev/sda3
mkfs.ext4 /dev/sda4

Mount:
mount /dev/sda3 /mnt
mkdir /mnt/boot /mnt/home
mount /dev/sda2 /mnt/boot
mount /dev/sda4 /mnt/home

mkswap /dev/sdax

pacstrap -i /mnt/ base base-devel

"""


def bash_success(args):
    completed = subprocess.run(
        args,
        encoding='utf-8',
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE
    )
    if completed.returncode == 0:
        return True
    else:
        return False


def bash_run(args):
    result = subprocess.run(
        args,
        encoding='utf-8',
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE
    )
    return result 


def input_d(prompt, default=None):
    if default is not None:
        text = '{} (default {}): '.format(prompt, default)
    else:
        text = '{}: '.format(prompt)
    result = input(text)
    if default is not None and len(result) == 0:
        result = default
    return result


def abort_script(message, exit_status=1):
    print(message)
    print('Aborting...')
    print()
    sys.exit(1)


def install_step_1():
    disk = input_d('Disk name', 'sda')
    args = ['sudo', 'fdisk', '-l', '/dev/{}'.format(disk)]
    if bash_success(args) is False:
        msg = '...disk \'{}\' not found.'.format(disk)
        abort_script(msg)
    args = ['grep', '/dev/{}'.format(disk), '/proc/mounts']
    if bash_success(args) is True:
        msg = '...disk \'{}\' is mounted! \nIs that the right disk?'.format(disk)
        abort_script(msg)
    print('Continuing...')


def start_install():
    install_step_1()
    print('Done.')


if __name__ == '__main__':
    start_install()
