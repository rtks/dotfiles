########
## PATH
set PATH "$HOME/bin" $PATH
# Android SDK
[ -e "$HOME/Developer/android-sdk-macosx/tools" ]
and set PATH "$HOME/Developer/android-sdk-macosx/tools" $PATH
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
set -gx FZF_DEFAULT_OPTS "--reverse --inline-info --ansi
  --bind ctrl-f:page-down,ctrl-b:page-up
  --color bg+:007,fg+:010,hl:009,hl+:009"
set -gx FZF_TMUX 1

########
## PowerLine
# PowerLineのセパレータをtmux.confで取得できるようにする
set -gx SEGMENT_SEPARATOR ''

switch "$FISH_VERSION"
    case 2.2.0 2.1.2 2.1.1 2.1.0 2.0.0
        cd
        for file in .config/fish/conf.d/*.fish
            source $file
        end
end
if test -n "$MSYSTEM"
  set -xg MSYS winsymlinks:nativestrict
end
