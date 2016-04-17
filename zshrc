############
## autoload
# cdr 最近使ったディレクトリを補完
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs

############
## 環境変数
# 言語
export LANG=ja_JP.UTF-8
export LC_CTYPE=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8
# GNUTERM
export GNUTERM=x11

############
## PATH設定
export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin"
export PATH="$HOME/bin:$PATH"
export PATH="/opt/X11/bin:$PATH"
export PATH="/Library/TeX/texbin:$PATH"
# NodeBrew
export NODE_PATH=$HOME/nodebrew/current/lib/node_modules
export PATH="$HOME/nodebrew/current/bin:$PATH"
# pyenv
export PATH="$HOME/pyenv/bin:$PATH"
# Android SDK
export PATH="$HOME/Developer/android-sdk-macosx/tools:$PATH"
# hrp2 ETロボコン
export HRP2KERNELDIR="$HOME/work/hrp2"
# Python
#export PATH="~/Library/Python/2.7/bin:$PATH"
#export PATH=/usr/local/share/python:$PATH
#source `which virtualenvwrapper.sh`
#export PYTHONPATH=/usr/local/lib/python2.7/site-packages:$PYTHONPATH
# iOS Open Dev
#export iOSOpenDevPath=/opt/iOSOpenDev
#export iOSOpenDevDevice=
#export PATH=/opt/iOSOpenDev/bin:$PATH

############
## zplug
if [ ! -f ~/.zplug/init.zsh ]; then
  printf "Install zplug? [y/N]: "
  if read -q; then
    echo; git clone --depth=1 -b v2 --single-branch https://github.com/b4b4r07/zplug.git ~/.zplug/repos/b4b4r07/zplug
    ln -s ~/.zplug/repos/b4b4r07/zplug/init.zsh ~/.zplug/init.zsh
    ZPLUG_INSTALL=true
  fi
fi
if [ -f ~/.zplug/init.zsh ]; then
  source ~/.zplug/init.zsh

  zplug "b4b4r07/zplug", at:v2
  zplug "lib/history", from:oh-my-zsh
  zplug "lib/theme-and-appearance", from:oh-my-zsh
  zplug "themes/agnoster", from:oh-my-zsh
  zplug "plugins/common-aliases", from:oh-my-zsh
  autoload -Uz is-at-least # common-aliasesはoh-my-zsh/libでロードされるis-at-leastを使用
  zplug "plugins/vi-like", from:oh-my-zsh
  zplug "plugins/brew", from:oh-my-zsh, if:"which brew"
  zplug "plugins/atom", from:oh-my-zsh, if:"which atom"
  zplug "lib/clipboard", from:oh-my-zsh, if:"[[ $OSTYPE == *darwin* ]]"
  zplug "plugins/osx", from:oh-my-zsh, if:"[[ $OSTYPE == *darwin* ]]"
  zplug "plugins/git", from:oh-my-zsh, if:"which git", nice:10
  zplug "zsh-users/zsh-syntax-highlighting", nice:10
  zplug "junegunn/fzf-bin", as:command, from:gh-r, rename-to:fzf
  zplug "junegunn/fzf", as:command, use:bin/fzf-tmux
  zplug "junegunn/fzf", use:shell/completion.zsh
  zplug "junegunn/fzf", use:shell/key-bindings.zsh
  zplug "mollifier/anyframe"
  zplug "b4b4r07/easy-oneliner"
  zplug "rupa/z", use:"*.sh"
  
  if [ "$ZPLUG_INSTALL" = true ]; then
    printf "Install zsh plugins? [y/N]: "
    if read -q; then
      echo; zplug install
    fi
  fi
  
  # Then, source plugins and add commands to $PATH
  zplug load
fi

############
## vim-plug
if [ ! -f ~/.vim/autoload/plug.vim ]; then
  printf "Install vim-plug? [y/N]: "
  if read -q; then
    echo; curl -fsSLo ~/.vim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    printf "Install vim-plug plugins? [y/N]: "
    if read -q; then
      vim +PlugUpdate +PlugClean! +qall
    fi
  fi
fi

############
## エイリアス
alias -g F='| fzf'
alias reload_shell='exec $SHELL'
alias platex='platex --kanji=utf8'
alias nf=terminal-notifier
alias more='more -R'

############
## zshの設定
# 補完候補リストの日本語を正しく表示
setopt print_eight_bit
# 補完時に濁点・半濁点を <3099> <309a> のように表示させない
setopt combining_chars
# 補完リストが多いときに尋ねない
LISTMAX=1000
# Historyを共有
setopt share_history
# コマンド実行時にHistoryに追記
setopt inc_append_history
# 重複したHistoryは追加しない
setopt hist_ignore_all_dups
# History検索中に重複を飛ばす
#setopt hist_find_no_dups
# 余分な空白は詰めて記録
setopt hist_ignore_space
# 冗長な空白を除く
setopt hist_reduce_blanks

############
## cdrの設定
zstyle ':chpwd:*' recent-dirs-max 500 # cdrの履歴を保存する個数
zstyle ':chpwd:*' recent-dirs-default yes
zstyle ':completion:*' recent-dirs-insert both

############
## zawの設定
# Case insensitiveにする
zstyle ':filter-select' case-insensitive yes
zstyle ':filter-select' max-lines 10
bindkey '^X^F' zaw-git-files
bindkey '^X^B' zaw-git-branches
bindkey '^X^P' zaw-process
#bindkey '^A' zaw-tmux

############
## fzfの設定
zstyle ':anyframe:selector:fzf:' command fzf-tmux
export MANPATH="\$MANPATH:$HOME/.zplug/repos/junegunn/fzf/man"
export FZF_DEFAULT_OPTS="--reverse --inline-info"
# zawのキーバインド
bindkey '^@' anyframe-widget-cdr

############
## agnosterテーマの設定
# 通常時はHost名とユーザー名を表示しない
export DEFAULT_USER=ryota
# PowerLineパッチの当たっていないフォント用
#export SEGMENT_SEPARATOR='⮀'
# PowerLineのセパレータをtmux.confで取得できるようにする
export SEGMENT_SEPARATOR=$SEGMENT_SEPARATOR
# agnosterテーマの調整
prompt_dir() {
  prompt_segment white default '%.'
}
prompt_context() {
  local user=`whoami`
  if [[ "$user" != "$DEFAULT_USER" || -n "$SSH_CONNECTION" ]]; then
    prompt_segment cyan black "%(!.%{%F{yellow}%}.)$user@%m"
  fi
}

############
## 速度測定
# 無効にする場合は~/.zshenvのzmodload zsh/zprof && zprofをコメントアウト
if (which zprof > /dev/null) ;then
  zprof | less
fi
