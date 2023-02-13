# dotfiles

## Install

if [yadm](https://yadm.io/) is already installed.

```bash
yadm clone https://github.com/rtks/dotfiles.git --bootstrap
```

curl

```bash
curl -sL takasu.dev/dotfiles | sh
```

wget

```bash
wget -qO - takasu.dev/dotfiles | sh
```


## Brew bundle

```bash
brew tap Homebrew/bundle
brew bundle
```

Update Brewfile.

```
brew bundle dump --force --file=~/.config/yadm/alt/.Brewfile##os.Darwin; for l in (diff -u (brew list | sort | psub) (brew leaves | sed 's#^.*/##' | sort | psub) | tail -n+3 | grep "^-" | cut -c2-); sed -i -e '/^brew "[^"]*'$l'"/d' ~/.config/yadm/alt/.Brewfile##os.Darwin; end
```

