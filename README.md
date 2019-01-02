# dotfiles

## Install

curl

```bash
curl -fsSL raw.github.com/rtks/dotfiles/master/install.sh | bash
```

wget

```bash
wget -qO - raw.github.com/rtks/dotfiles/master/install.sh | bash
```

## Manual install

```bash
brew install rcm
git clone --recursive https://github.com/rtks/dotfiles.git ~/.dotfiles
env RCRC=$HOME/.dotfiles/rcrc rcup
~/.dotfiles/vscode/setup.sh
```
## vim-plug

```bash
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

## Fisheman

```bash
curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs git.io/fisher
```

## Brew bundle

```bash
brew tap Homebrew/bundle
cd ~/.dotfiles
brew bundle
```
Update Brewfile.

```
brew bundle dump --force --file=~/.dotfiles/Brewfile; for l in (diff -u (brew list | sort | psub) (brew leaves | sed 's#^.*/##' | sort | psub) | tail -n+3 | grep "^-" | cut -c2-); sed -i -e "/^brew '[^']*$l'/d" ~/.dotfiles/Brewfile; end
```

## VSCode

Install packages.

```bash
bash ~/.dotfiles/vscode/extensions
```

Update package list.

```bash
code --list-extensions | xargs -L 1 echo code --install-extension >~/.dotfiles/vscode/extensions
```
