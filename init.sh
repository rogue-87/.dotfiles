#!/bin/bash

## add repos
sudo dnf copr enable atim/lazygit -y
sudo dnf install lazygit

native_packages=(
  neovim
  kitty
  fastfetch
  btop
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
  lazygit
)

npm_g_packages=(
  neovim
  yarn
  pnpm
  browser-sync
  vscode-langservers-extracted
  typescript
  typescript-language-server
  @vue/language-server
  @vue/typescript-plugin
)

# set up path for global npm packages
PREFIX="$HOME/.npm/packages"
if [ ! -d "$PREFIX" ]; then
  echo "Creating prefix directory: $PREFIX"
  mkdir -p "$PREFIX"
fi
npm config set prefix "$PREFIX"
echo "Global npm prefix set to: $PREFIX"

# install packages
sudo dnf install "${system_packages[@]}" 
npm i -g "${npm_g_packages[@]}"

# seriously why mpd don't use these paths instead
mkdir ~/.local/share/mpd/
mkdir ~/.local/share/mpd/lyrics
mkdir ~/.local/share/mpd/playlists
touch ~/.local/share/mpd/pid
touch ~/.local/share/mpd/database

# write bashrc-template into .bashrc
mv $HOME/.bashrc $HOME/.bashrc.bak
cp ./bashrc-template $HOME/.bashrc

# finally activate dotfiles using stow
stow .
