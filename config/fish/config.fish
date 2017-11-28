switch "$FISH_VERSION"
    case 2.2.0 2.1.2 2.1.1 2.1.0 2.0.0
        cd
        for file in .config/fish/conf.d/*.fish
            source $file
        end
end

########
## PATH
set PATH "$HOME/bin" $PATH
if [ -d ~/.dotfiles/rcm ]
  set PATH "$HOME/.dotfiles/rcm/bin" $PATH
  set MANPATH "$HOME/.dotfiles/rcm/share/man" $MANPATH
end
if [ -d ~/.local/bin ]
  set PATH "$HOME/.local/bin" $PATH
end
if [ -d ~/.local/share/man ]
  set MANPATH "$HOME/.local/share/man" $MANPATH
end
if [ -d /usr/local/share/man ]
  set MANPATH /usr/local/share/man $MANPATH
end
# Android SDK
if [ -d "$HOME/Developer/android-sdk-macosx/tools" ]
  set PATH "$HOME/Developer/android-sdk-macosx/tools" $PATH
end
# Homebrew fish
if [ -d /usr/local/share/fish/vendor_completions.d ]
  set fish_complete_path /usr/local/share/fish/vendor_completions.d $fish_complete_path
end
# C/C++
if [ -d /usr/local/include ]
  set -x C_INCLUDE_PATH (string join : /usr/local/include $C_INCLUDE_PATH)
  set -x CPLUS_INCLUDE_PATH (string join : /usr/local/include $CPLUS_INCLUDE_PATH)
end
if [ -d /usr/local/lib ]
  set -x LIBRARY_PATH (string join : /usr/local/lib $LIBRARY_PATH)
  set -x LD_LIBRARY_PATH (string join : /usr/local/lib $LD_LIBRARY_PATH)
end
if [ -d /usr/local/lib/pkgconfig ]
  set -x PKG_CONFIG_PATH (string join : /usr/local/lib/pkgconfig $PKG_CONFIG_PATH)
end
#set PATH /opt/X11/bin $PATH
#set PATH /Library/TeX/texbin $PATH
# NodeBrew
#set -gx NODE_PATH "$HOME/nodebrew/current/lib/node_modules"
#set PATH "$HOME/nodebrew/current/bin" $PATH
# pyenv
#set PATH "$HOME/pyenv/bin" $PATH
# Python
#export PATH="~/Library/Python/2.7/bin:$PATH"
#export PATH=/usr/local/share/python:$PATH
#source `which virtualenvwrapper.sh`
#export PYTHONPATH=/usr/local/lib/python2.7/site-packages:$PYTHONPATH
# iOS Open Dev
#export iOSOpenDevPath=/opt/iOSOpenDev
#export iOSOpenDevDevice=
#export PATH=/opt/iOSOpenDev/bin:$PATH

########
## LS
set -gx LSCOLORS Gxfxcxdxbxegedabagacad

########
## FZF
set -gx FZF_DEFAULT_OPTS "--reverse --inline-info --ansi\
 --bind ctrl-f:page-down,ctrl-b:page-up\
 --color bg+:007,fg+:010,hl:009,hl+:009"
set -gx FZF_TMUX 1

########
## PowerLine
# PowerLineのセパレータをtmux.confで取得できるようにする
set -gx SEGMENT_SEPARATOR ''

for file in .config/fish/conf.override.d/*.fish
    source $file
end

if test -n "$MSYSTEM"
  set -xg MSYS winsymlinks:nativestrict
end
