########
## PATH
function __add_path
  if [ -d $argv[2] ]
    if set -q $argv[1]
      if ! contains $argv[2] $$argv[1]
        set -p $argv[1] $argv[2]
      end
    else
      if [ $argv[1] = MANPATH ]
        set -gx $argv[1] $argv[2] (manpath)
      else
        set -gx $argv[1] $argv[2]
      end
    end
  end
end
# Homebrew
if type -q arch && [ (arch) = arm64 ];
  if [ -f /opt/homebrew/bin/brew ]
    eval (/opt/homebrew/bin/brew shellenv)
  end
else
  if [ -f /usr/local/bin/brew ]
    eval (/usr/local/bin/brew shellenv)
  end
end 
if [ -f /home/linuxbrew/.linuxbrew/bin/brew ]
  eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
else
  # In Linuxbrew, adding to LD_LIBRARY_PATH makes references from executables strange.
  __add_path LD_LIBRARY_PATH $HOMEBREW_PREFIX/lib
  __add_path LIBRARY_PATH $HOMEBREW_PREFIX/lib
  __add_path C_INCLUDE_PATH $HOMEBREW_PREFIX/include
  __add_path CPLUS_INCLUDE_PATH $HOMEBREW_PREFIX/include
  __add_path PKG_CONFIG_PATH $HOMEBREW_PREFIX/lib/pkgconfig
end
__add_path PATH $HOMEBREW_PREFIX/opt/python/libexec/bin
__add_path fish_complete_path $HOMEBREW_PREFIX/share/fish/vendor_completions.d
# Rust Cargo
__add_path PATH $HOME/.cargo/bin
# Go
__add_path PATH $HOME/go/bin
# Android SDK
__add_path PATH $HOME/Developer/android-sdk-macosx/tools
# .local
__add_path PATH $HOME/.local/bin
__add_path MANPATH $HOME/.local/share/man

########
## ENVS
set -gx SHELL (type -P fish)
set -gx EDITOR (type -P vim)

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
set -U FZF_DISABLE_KEYBINDINGS 1

########
# skim
set -gx SKIM_DEFAULT_OPTIONS '--inline-info --ansi --layout=reverse --min-height=0 --color=light,bg+:7'

########
# pyenv
if [ -d "$HOME/.pyenv" ]
  set -gx PYENV_ROOT "$HOME/.pyenv"
  __add_path PATH "$PYENV_ROOT/bin"
  pyenv init - | source
end

########
# msys
if [ -n $MSYSTEM ]
  set -gx MSYS winsymlinks:nativestrict
end

test -e {$HOME}/.iterm2_shell_integration.fish; and source {$HOME}/.iterm2_shell_integration.fish

functions -e __add_path
