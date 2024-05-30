#!/bin/bash

## add repos

# add lazygit repo
sudo dnf copr enable atim/lazygit -y

# add charm repo
echo '[charm]
name=Charm
baseurl=https://repo.charm.sh/yum/
enabled=1
gpgcheck=1
gpgkey=https://repo.charm.sh/yum/gpg.key' | sudo tee /etc/yum.repos.d/charm.repo
sudo yum install glow


## packages list
packages=(
  neovim
  kitty
  fastfetch
  btop
  cava
  ncmpcpp
  mpd
  ranger
  lazygit
  stow
  npm
  nodejs
  python3
  pip
  lua
  luarocks
  gloang
  rust
)

## npm packages(required by neovim plugins)
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
sudo dnf install "${packages[@]}" 
npm i -g "${npm_g_packages[@]}"

# seriously why mpd don't use these paths instead
mkdir ~/.local/share/mpd/
mkdir ~/.local/share/mpd/lyrics
mkdir ~/.local/share/mpd/playlists
touch ~/.local/share/mpd/pid
touch ~/.local/share/mpd/database

# bak up .bashrc just in case :)
mv $HOME/.bashrc $HOME/.bashrc.bak

# finally activate dotfiles using stow
stow .
