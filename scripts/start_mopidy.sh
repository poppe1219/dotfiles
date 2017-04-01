#!/usr/bin/bash

read -s -p "Spotify password: " password
mopidy -o spotify/password="${password}"
