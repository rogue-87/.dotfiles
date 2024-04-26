#!/bin/bash

packages=(
  neovim
  kitty
  cava
  ncmpcpp
  mpd
  stow
  npm
  nodejs
  python3
  pip
  lua
  luarocks
)
sudo dnf install "${packages[@]}" 

# seriously why mpd don't use these paths instead
mkdir ~/.local/share/mpd/
mkdir ~/.local/share/mpd/lyrics
mkdir ~/.local/share/mpd/playlists
touch ~/.local/share/mpd/pid
touch ~/.local/share/mpd/database

PREFIX="/home/rogue/.npm-packages"

if [ ! -d "$PREFIX" ]; then
  echo "Creating prefix directory: $PREFIX"
  mkdir -p "$PREFIX"
fi
npm config set prefix "$PREFIX"
echo "Global npm prefix set to: $PREFIX"
