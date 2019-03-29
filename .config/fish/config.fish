switch "$FISH_VERSION"
    case 2.2.0 2.1.2 2.1.1 2.1.0 2.0.0
      set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
      for file in $XDG_CONFIG_HOME/fish/conf.d/*.fish
        builtin source $file 2>/dev/null
      end
end

########
## PATH
set PATH "$HOME/bin" $PATH
set MANPATH (string split : (manpath -q))
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
if [ -d /usr/local/sbin ]
  set PATH /usr/local/sbin $PATH
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
# git diff-highlight
if [ -d /usr/local/share/git-core/contrib/diff-highlight ]
  set PATH /usr/local/share/git-core/contrib/diff-highlight $PATH
end

########
## LS
set -gx LSCOLORS GxfxcxdxAxegedabagacad
set -gx LS_COLORS 'rs=0:di=1;36:ln=35:mh=0:pi=33:so=32:do=0:bd=0:cd=0:or=40;31;01:mi=00:su=0;31:sg=0;46:ca=0;41:tw=0;43:ow=0:st=0;43:ex=1'

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

########
# msys
if test -n "$MSYSTEM"
  set -xg MSYS winsymlinks:nativestrict
end

for file in .config/fish/conf.override.d/*.fish
    source $file
end
