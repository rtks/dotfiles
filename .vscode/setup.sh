#!/bin/bash

if [ `uname` == 'Darwin' ]; then
    VSCODE_USER="$HOME/Library/Application Support/Code/User"
    DOTFILES="$HOME/.vscode"
elif [ -n "$MSYSTEM" ]; then
    VSCODE_USER="$HOME/AppData/Roaming/Code/User"
    DOTFILES="$HOME/.vscode"
elif [[ `uname -a` =~ Linux && `uname -a` =~ Microsoft ]]; then
    VSCODE_USER="$HOME/AppData/Roaming/Code/User"
    DOTFILES="../../../../.vscode"
elif [ "$(expr substr `uname -s` 1 5)" == 'Linux' ]; then
    VSCODE_USER="$HOME/.config/Code/User"
    DOTFILES="$HOME/.vscode"
else
    echo "OS is unknown. Exit VSCode setup."
    return -1
fi

echo "Creating VSCode Symbolic links"
cd "$VSCODE_USER"
ln -si $DOTFILES/settings.json settings.json
ln -si $DOTFILES/keybindings.json keybindings.json
rm -ri snippets
ln -s $DOTFILES/snippets snippets
echo "Done!"

echo "Installing VSCode extentions"
bash $DOTFILES/extensions.sh
echo "Done!"
