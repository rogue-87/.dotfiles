#!/bin/bash

## packages list
packages=(
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
  luajit
  luarocks
  gloang
  rust
  fish

  lua-language-server
  stylua
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

# set up path for global npm packages
PREFIX="$HOME/.npm/packages"
if [ ! -d "$PREFIX" ]; then
  echo "Creating prefix directory: $PREFIX"
  mkdir -p "$PREFIX"
fi
npm config set prefix "$PREFIX"
echo "Global npm prefix set to: $PREFIX"

# install packages
pkg install "${packages[@]}"
npm i -g "${npm_g_packages[@]}"

# bak up .bashrc just in case :)
mv $HOME/.bashrc $HOME/.bashrc.bak

# finally activate dotfiles using stow
stow .
