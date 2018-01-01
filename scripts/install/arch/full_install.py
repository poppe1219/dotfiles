#!/usr/bin/env python3

import sys
import subprocess


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


def abort_script(message, exit_status=1):
    print(message)
    print('Aborting...')
    print()
    sys.exit(1)


def run_stuff():
    # ['sudo', 'fdisk', '-l', '/dev/{}'.format(disk)],
    disk = input('Disk name, typically "sda"? ')
    args = ['grep', '/dev/{}'.format(disk), '/proc/mounts']
    if bash_success(args) is True:
        msg = '...disk "{}" is mounted! \nIs that the right disk?'.format(disk)
        abort_script(msg)
    print('Continuing...')
    print('Done.')


if __name__ == '__main__':
    #var1 = run_script_1()
    #var2 = run_script_2(var1)
    #var3 = run_script_3(var2)
    run_stuff()
