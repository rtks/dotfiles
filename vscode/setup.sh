#!/bin/bash

if [ "$(uname)" == 'Darwin' ]; then
    VSCODE_USER="$HOME/Library/Application Support/Code/User"
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
    VSCODE_USER="$HOME/.config/Code/User"
elif [ -n "$MSYSTEM" ]; then
    VSCODE_USER="$HOME/AppData/Roaming/Code/User"
else
    echo "OS is unknown. Exit VSCode setup."
    return -1
fi

echo "Creating VSCode Symbolic links"
ln -si ~/.dotfiles/vscode/settings.json "$VSCODE_USER/settings.json"
ln -si ~/.dotfiles/vscode/keybindings.json "$VSCODE_USER/keybindings.json"
rm -i "$VSCODE_USER/snippets"
ln -s ~/.dotfiles/vscode/snippets "$VSCODE_USER/snippets"
echo "Done!"

echo "Installing VSCode extentions"
bash ~/.dotfiles/vscode/extensions
echo "Done!"
