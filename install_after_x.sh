#!/bin/bash

xrandr --output `xrandr --listmonitors | grep "0:" | cut -d " " -f 6` --auto
htop
