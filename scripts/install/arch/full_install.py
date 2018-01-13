#!/usr/bin/env python3

import os
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


def bash_success(command):
    result = subprocess.run(
        command,
        env=os.environ.copy(),
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        encoding='utf-8',
        shell=True
    )
    if result.returncode == 0:
        return True
    else:
        return False


def bash_run(command):
    result = subprocess.run(
        command,
        env=os.environ.copy(),
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        encoding='utf-8',
        shell=True
    )
    #result = subprocess.run(
    #    args,
    #    encoding='utf-8',
    #    stdout=subprocess.PIPE,
    #    stderr=subprocess.PIPE,
    #    shell=True
    #)
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


def get_mem_size_kb():
    result = bash_run('grep MemTotal: /proc/meminfo')
    mem_line = result.stdout
    if len(mem_line) > 0:
        # Ex: "MemTotal:       132039544 kB"
        mem_size = mem_line.replace('MemTotal:', '').replace('kB', '').strip()
    else:
        mem_size = -1
    return int(mem_size)


def get_user():
    result = bash_run('echo $USER')
    return result.stdout


def get_disk_size(disk_name):
    command = 'sudo blockdev --getsize64 /dev/{}'.format(disk_name)
    print('COMMAND:', command)
    result = bash_run(command)
    value = result.stdout
    print('SIZE: {}'.format(value))
    if value == '':
        value = '0'
    return int(value)


def install_step_1():
    user = get_user()
    print('USER: {}'.format(user))
    mem = get_mem_size_kb()
    print('Avaliable memory: {0:.1f}'.format(mem/1000000))
    disk_name = input_d('Disk name', 'sda')
    command = 'sudo fdisk -l /dev/{}'.format(disk_name)
    if bash_success(command) is False:
        msg = '...disk \'{}\' not found.'.format(disk_name)
        abort_script(msg)
    command = 'grep /dev/{} /proc/mounts'.format(disk_name)
    if bash_success(command) is True:
        msg = '...disk \'{}\' is mounted! \nIs that the right disk?'.format(
            disk_name
        )
        abort_script(msg)
    disk_size = get_disk_size(disk_name)
    print('Disk size: {0:.1f}'.format(disk_size/1024/1000000))
    swap_size = input_d('Swap partition size', '1GB')
    print('Continuing...')


def start_install():
    install_step_1()
    print('Done.')


if __name__ == '__main__':
    start_install()
