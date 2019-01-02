#!/bin/bash

DOTPATH="$HOME/.dotfiles"
DOT_GIT="https://github.com/rtks/dotfiles.git"
DOT_URL="https://github.com/rtks/dotfiles/archive/master.tar.gz"
RCM_URL="https://thoughtbot.github.io/rcm/dist/rcm-1.3.0.tar.gz"
RCM_DIR=rcm

is_exists() {
    type "$1" >/dev/null 2>&1
    return $?
}

if [ -d "$DOTPATH" ]; then
  echo "already exists $DOTPATH"
  read -p "Use this? [y/N]: " -n 1 -r
  echo; if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "cancel install"
    exit 1
  fi
else
  if is_exists git; then
      git clone --recursive "$DOT_GIT" "$DOTPATH"
  else
    mkdir "$DOTPATH"
    if is_exists curl; then
        curl -fsSL "$DOT_URL" | tar xfz - -C "$DOTPATH" --strip-components 1
    else
        wget -qO - "$DOT_URL" | tar xfz - -C "$DOTPATH" --strip-components 1
    fi
  fi
fi

if ! is_exists lsrc; then
  if [ ! -x "$DOTPATH/$RCM_DIR/bin/lsrc" ]; then
    echo "downloading rcm"
    PREFIX="$DOTPATH/$RCM_DIR"
  	mkdir -p "$PREFIX/temp"
    cd "$PREFIX/temp"
    curl -fsSL "$RCM_URL" | tar xfz - --strip-components 1
    ./configure --prefix="$PREFIX" >/dev/null
    make install >/dev/null
    rm -Rf "$PREFIX/temp"
    cd "$HOME"
  fi
  export PATH="$PATH:$DOTPATH/$RCM_DIR/bin"
fi

echo "installing .dotfiles"
env RCRC="$DOTPATH/rcrc" rcup -v
$DOTPATH/vscode/setup.sh
echo "completed!!!"
