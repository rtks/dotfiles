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
