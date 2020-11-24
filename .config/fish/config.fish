########
## PATH
if [ -d /usr/local/share/man ]
  set -xp MANPATH /usr/local/share/man
end
if [ -d /usr/local/sbin ]
  set -xp PATH /usr/local/sbin
end
# Homebrew fish
if [ -d /usr/local/share/fish/vendor_completions.d ]
  set -xp fish_complete_path /usr/local/share/fish/vendor_completions.d
end
# C/C++
if [ -d /usr/local/include ]
  set -xp C_INCLUDE_PATH /usr/local/include
  set -xp CPLUS_INCLUDE_PATH /usr/local/include
end
if [ -d /usr/local/lib ]
  set -xp LIBRARY_PATH /usr/local/lib
  set -xp LD_LIBRARY_PATH /usr/local/lib
end
if [ -d /usr/local/lib/pkgconfig ]
  set -xp PKG_CONFIG_PATH /usr/local/lib/pkgconfig
end

if type -q arch && [ (arch) = arm64 ];
  if [ -d /opt/homebrew/bin ]
    set -xp PATH /opt/homebrew/bin
  end
  if [ -d /opt/homebrew/share/man ]
    set -xp MANPATH /opt/homebrew/share/man
  end
  if [ -d /opt/homebre/include ]
    set -xp C_INCLUDE_PATH /opt/homebre/include
    set -xp CPLUS_INCLUDE_PATH /opt/homebre/include
  end
  if [ -d /opt/homebrew/lib ]
    set -xp LIBRARY_PATH /opt/homebrew/lib
    set -xp LD_LIBRARY_PATH /opt/homebrew/lib
  end
  if [ -d /opt/homebrew/share/fish/vendor_completions.d ]
    set -xp fish_complete_path /opt/homebrew/share/fish/vendor_completions.d
  end
end 

if type -q manpath
  set -x MANPATH (string split : (manpath -q))
end
if [ -d ~/.dotfiles/rcm ]
  set -xp PATH "$HOME/.dotfiles/rcm/bin"
  set -xp MANPATH "$HOME/.dotfiles/rcm/share/man"
end
if [ -d ~/.local/bin ]
  set -xp PATH "$HOME/.local/bin"
end
if [ -d ~/.local/share/man ]
  set -xp MANPATH "$HOME/.local/share/man"
end
if [ -d "$HOME/.cargo/bin" ]
  set -xp PATH "$HOME/.cargo/bin"
end
if [ -d "$HOME/go/bin" ]
  set -xp PATH "$HOME/go/bin"
end
# Android SDK
if [ -d "$HOME/Developer/android-sdk-macosx/tools" ]
  set -xp PATH "$HOME/Developer/android-sdk-macosx/tools"
end

########
## LS
set -gx LSCOLORS GxfxcxdxAxegedabagacad
set -gx LS_COLORS 'rs=0:di=1;36:ln=35:mh=0:pi=33:so=32:do=0:bd=0:cd=0:or=40;31;01:mi=00:su=0;31:sg=0;46:ca=0;41:tw=0;43:ow=0:st=0;43:ex=1;30'

########
## FZF
set -gx FZF_DEFAULT_OPTS "--reverse --inline-info --ansi\
 --bind ctrl-f:page-down,ctrl-b:page-up\
 --color bg+:007,fg+:010,hl:009,hl+:009"
set -gx FZF_TMUX 1

########
## PowerLine
# PowerLineのセパレータをtmux.confで取得できるようにする
set -gx SEGMENT_SEPARATOR '���'

########
# msys
if test -n "$MSYSTEM"
  set -xg MSYS winsymlinks:nativestrict
end

for file in .config/fish/conf.override.d/*.fish
    source $file
end
