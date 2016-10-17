#!/bin/bash

xrandr --output `xrandr --listmonitors | grep "0:" | cut -d " " -f 6` --auto
nitrogen --restore

i3-msg split v
i3-msg exec "i3-sensible-terminal"
sleep 0.2
i3-msg split h
i3-msg exec "i3-sensible-terminal"

htop
