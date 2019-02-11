#!/bin/bash
. "$(dirname "$BASH_SOURCE")/../utils/echo.sh"

if test ! "$( aurman --version )"; then
    title "Installing aurman"
    [ -d /tmp/aurman ] && sudo rm -rf /tmp/aurman
    git clone https://aur.archlinux.org/aurman.git /tmp/aurman
    cd /tmp/aurman || exit
    makepkg -Acs
    AURMAN="$(ls -1 | grep tar.xz)"
    sudo pacman -U "$AURMAN"
fi

aurs=(
    autokey-py3
    cheat-git
    polybar-git
    visual-studio-code-bin
    typora
)

title "Installing aur packages..."

for aur in "${aurs[@]}"; do
    aur_name=$( echo "$aur" | awk '{print $1}' )
    if pacman -Q "$aur_name" > /dev/null 2>&1; then
        warn "$aur_name already installed..."
    else
        progress "Installing $aur_name"
        aurman -S "$aur" --noconfirm
    fi
done
