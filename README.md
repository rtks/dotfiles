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
