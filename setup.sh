#!/bin/bash

system_packages=(
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

npm_g_packages=(
  neovim
  yarn
  pnpm
  browser-sync
  vscode-langservers-extracted
  typescript
  typescript-language-server
  @vue-language-server
)

sudo dnf install "${system_packages[@]}" 
npm i -g "${npm_g_packages[@]}"

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

stow .
