#!/bin/bash
. "$(dirname "$BASH_SOURCE")/../utils.sh"

dev=(
  ack
  alsa-utils
  autoconf
  automake
  bat
  bind-tools
  binutils
  bluez
  bluez-utils
  curl
  diff-so-fancy
  dosfstools
  file
  findutils
  fx
  fzf
  gawk
  gcc
  git
  go
  grep
  gzip
  lm_sensors
  make
  mtools
  net-tools
  nmap
  numlockx
  patch
  perl-rename
  pkgconf
  pulseaudio
  python
  python-pip
  rust
  sed
  shellcheck
  sudo
  tree
  unrar
  unzip
  vim
  wget
  which
  xdg-user-dirs
  xdg-utils
  zip
  zsh
)

title "Installing dev packages..."

sudo pacman -S --needed base-devel

for pkg in "${dev[@]}"; do
  pkg_name=$(echo "$pkg" | awk '{print $1}')
  progress "Installing $pkg_name"
  sudo pacman -Sq "$pkg" --noconfirm > /dev/null
done
