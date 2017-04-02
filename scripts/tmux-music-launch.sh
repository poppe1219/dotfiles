#!/bin/bash

tmux new -d -s music

tmux rename-window mopidy
tmux send-keys "~/git/dotfiles/scripts/start_mopidy.sh" C-m
tmux new-window -n ncmpcpp
tmux send-keys "ncmpcpp"

tmux select-window -t 1 # The tmux.conf sets 1 as the first window.

tmux attach-session -t music
