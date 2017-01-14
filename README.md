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

## Atom

Install packages.

```bash
cd ~/.dotfiles
apm install --packages-file atom/packages.txt
```

Update package list.

```bash
cd ~/.dotfiles
apm list --installed --bare | grep -o '^[^@]\+' | grep -v '^_' > atom/packages.txt
```
