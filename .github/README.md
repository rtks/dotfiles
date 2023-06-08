# dotfiles

## Install

if [yadm](https://yadm.io/) is already installed.

```bash
yadm clone https://github.com/rtks/dotfiles.git --bootstrap
```

curl

```bash
bash -c "$(curl -sL takasu.dev/dotfiles)"
```

wget

```bash
bash -c "$(wget -qO - takasu.dev/dotfiles)"
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

