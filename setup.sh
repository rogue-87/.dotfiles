#!/bin/bash

## vscodium
read -p "Do you want to install vscodium? (yes/no): " answer
if [[ "$answer" == "yes" ]]; then
  echo "installing vscodium"
  sudo rpmkeys --import https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg
  printf "[gitlab.com_paulcarroty_vscodium_repo]\nname=download.vscodium.com\nbaseurl=https://download.vscodium.com/rpms/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg\nmetadata_expire=1h" | sudo tee -a /etc/yum.repos.d/vscodium.repo
  sudo dnf install codium
elif [[ "$answer" == "no" ]]; then
  echo "Skipping"
  sleep "2s"
else
  echo "Invalid input. Exiting..."
  exit
fi

## lazygit copr repo
sudo dnf copr enable atim/lazygit -y

## add charm repo
echo '[charm]
name=Charm
baseurl=https://repo.charm.sh/yum/
enabled=1
gpgcheck=1
gpgkey=https://repo.charm.sh/yum/gpg.key' | sudo tee /etc/yum.repos.d/charm.repo

## packages list
packages=(
  kitty
  neovim
  fastfetch
  stow
  btop
  cava
  lazygit
  npm
  nodejs
  python3
  pip
  lua
  luarocks
  gloang
  rust
  fish
)

## npm packages(required by neovim plugins)
npm_g_packages=(
  @vue/language-server@2.0.22
  @vue/typescript-plugin@2.0.21
  all-the-package-names@2.0.1583
  browser-sync@3.0.2
  eslint@9.5.0
  neovim@5.1.0
  pnpm@9.4.0
  typescript-language-server@4.3.3
  typescript@5.4.5
  yarn@1.22.22
)

## set up path for global npm packages
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

# bak up .bashrc just in case :)
mv $HOME/.bashrc $HOME/.bashrc.bak

# finally activate dotfiles using stow
stow .
