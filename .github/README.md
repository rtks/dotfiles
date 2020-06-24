# dotfiles

## Install

if [yadm](https://yadm.io/) is already installed.

```bash
yadm clone https://github.com/rtks/dotfiles.git --bootstrap
```

curl

```bash
curl -sL takasu.dev/setup | sh
```

wget

```bash
wget -qO - takasu.dev/setup | sh
```


## Brew bundle

```bash
brew tap Homebrew/bundle
brew bundle
```

Update Brewfile.

```
brew bundle dump --force --file=~/.Brewfile; for l in (diff -u (brew list | sort | psub) (brew leaves | sed 's#^.*/##' | sort | psub) | tail -n+3 | grep "^-" | cut -c2-); sed -i -e "/^brew '[^']*$l'/d" ~/.Brewfile; end
```


## VSCode

Install packages.

```bash
bash ~/.vscode/extensions.sh
```

Update package list.

```bash
code --list-extensions | xargs -L 1 echo code --install-extension >~/.vscode/extensions.sh
```
