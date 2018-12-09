#!/bin/bash
INSTALLDIR=$(dirname "$BASH_SOURCE")
. "$INSTALLDIR/../utils/echo.sh"

read -rn 1 -p "Update Mirrors? [y/N] " umirrors
echo

if [[ $umirrors =~ ^([Yy])$ ]]; then
    title "Update Mirrors"
    sudo pacman-mirrors --fasttrack
fi


read -rn 1 -p "Sync Mirrors? [y/N] " sync
echo
if [[ $sync =~ ^([Yy])$ ]]; then
    title "Sync Mirrors"
    sudo pacman -Syyu
fi

title "Installing pacman packages..."
formulas=(
    ack
    bat
    chromium
    flameshot
    git
    gcc
    grep
    mongodb
    neovim
    python
    peek
    rofi
    shellcheck
    telegram-desktop
    termite
    tmux
    tree
    unrar
    unzip
    wget
    yarn
    z
    zsh
)

for formula in "${formulas[@]}"; do
    formula_name=$( echo "$formula" | awk '{print $1}' )
    if pacman -Q "$formula_name" > /dev/null 2>&1; then
        warn "$formula_name already installed..."
    else
        progress "Installing $formula_name"
        sudo pacman -S "$formula" --noconfirm
    fi
done

title "Clean the nonneeded packages..."
sudo pacman -Rns "$(pacman -Qtdq)"