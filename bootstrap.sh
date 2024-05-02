#!/bin/bash

# add repos
sudo dnf copr enable atim/lazygit -y
sudo dnf install lazygit

sudo rpmkeys --import https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg
printf "[gitlab.com_paulcarroty_vscodium_repo]\nname=gitlab.com_paulcarroty_vscodium_repo\nbaseurl=https://download.vscodium.com/rpms/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg\nmetadata_expire=1h" | sudo tee -a /etc/zypp/repos.d/vscodium.repo


native_packages=(
  neovim
  kitty
  fastfetch
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
  codium
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
  @vue-language-server
)

# set up path for global npm packages
PREFIX="/home/rogue/.npm-packages"
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

# finally activate dotfiles with stow
stow .
