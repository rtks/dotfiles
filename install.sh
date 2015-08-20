DOTPATH=~/.dotfiles
DOT_GIT="https://github.com/rtks/dotfiles.git"
DOT_URL="https://github.com/rtks/dotfiles/archive/master.tar.gz"
RCM_URL="https://thoughtbot.github.io/rcm/dist/rcm-1.2.3.tar.gz"
RCM_DIR=rcm

is_exists() {
    type "$1" >/dev/null 2>&1
    return $?
}

if [ -d "$DOTPATH" ]; then
    echo "$DOTPATH: already exists"
    exit -1
fi

if is_exists git; then
    git clone --recursive "$DOT_GIT" "$DOTPATH"
else
    mkdir "$DOTPATH"
	curl -L "$DOT_URL" | tar xvfz - -C "$DOTPATH" --strip-components 1
fi

if is_exists lsrc; then
    :
else
    cd "$DOTPATH"
	mkdir "$RCM_DIR"
	cd "$RCM_DIR"
	PREFIX=`pwd`
	mkdir "cache"
    cd "cache"
    curl -L "$RCM_URL" | tar xvfz - --strip-components 1
    ./configure --prefix="$PREFIX"
    make install-exec
    cd ../
    rm -Rf cache
    cd bin
    export PATH=$PATH:`pwd`
fi
env RCRC="$DOTPATH/rcrc" rcup -d "$DOTPATH"