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
## agnosterテーマの調整
__fix_omz_theme() {
  prompt_dir() {
    prompt_segment white default '%.'
  }
  prompt_context() {
    local user=`whoami`
    if [[ "$user" != "$DEFAULT_USER" || -n "$SSH_CONNECTION" ]]; then
      prompt_segment cyan black "%(!.%{%F{yellow}%}.)$user@%m"
    fi
  }
}

############
## zplug
if [ ! -f ~/.zplug/init.zsh ]; then
  printf "Install zplug? [y/N]: "
  if read -q; then
    echo; git clone --depth=1 -b v2 --single-branch https://github.com/zplug/zplug.git ~/.zplug/repos/b4b4r07/zplug
    ln -s ~/.zplug/repos/zplug/zplug/init.zsh ~/.zplug/init.zsh
    ZPLUG_INSTALL=true
  fi
fi
if [ -f ~/.zplug/init.zsh ]; then
  source ~/.zplug/init.zsh
  zplugs=()

  zplug "zplug/zplug"
  zplug "lib/history", from:oh-my-zsh
  zplug "lib/completion", from:oh-my-zsh
  zplug "lib/theme-and-appearance", from:oh-my-zsh
  zplug "lib/termsupport", from:oh-my-zsh
  zplug "themes/agnoster", from:oh-my-zsh, hook-load:"__fix_omz_theme"
  zplug "plugins/common-aliases", from:oh-my-zsh, nice:5, hook-load:"unalias \P"
  autoload -Uz is-at-least # common-aliasesはoh-my-zsh/libでロードされるis-at-leastを使用
  zplug "plugins/vi-mode", from:oh-my-zsh
  zplug "plugins/tmux", from:oh-my-zsh, if:"which tmux", nice:10
  zplug "plugins/brew", from:oh-my-zsh, if:"which brew"
  zplug "plugins/atom", from:oh-my-zsh, if:"which atom"
  zplug "lib/clipboard", from:oh-my-zsh, if:"[[ $OSTYPE == *darwin* ]]"
  zplug "plugins/osx", from:oh-my-zsh, if:"[[ $OSTYPE == *darwin* ]]"
  zplug "plugins/git", from:oh-my-zsh, if:"which git", nice:10
  zplug "zsh-users/zsh-syntax-highlighting", nice:10
  zplug "junegunn/fzf-bin", as:command, from:gh-r, rename-to:fzf
  zplug "junegunn/fzf", as:command, use:bin/fzf-tmux
  zplug "junegunn/fzf", use:shell/completion.zsh, nice:10
  zplug "junegunn/fzf", use:shell/key-bindings.zsh, nice:10
  zplug "mollifier/anyframe"
  zplug "b4b4r07/easy-oneliner"
  zplug "rupa/z", use:"*.sh"
  zplug "willghatch/zsh-cdr"
  zplug "rtks/90bf454eefa7ef9ee1830ae955a9a8c4", from:gist
  zplug "Tarrasch/zsh-bd", use:bd.zsh
  zplug "zsh-users/zsh-autosuggestions", at:"v0.3.x"
  zplug "zsh-users/zsh-completions"
  
  # Then, source plugins and add commands to $PATH
  zplug load --verbose 2> $ZPLUG_CACHE_FILE.log
  if [ ! "$(cat $ZPLUG_CACHE_FILE.log | grep 'Static loading...')" ]; then
    if ! zplug check --verbose; then
      printf "Install zsh plugins? [y/N]: "
      if read -q; then
        echo; zplug install
      fi
    fi
  fi
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

# 補完関数の表示を強化する
zstyle ':completion:*' verbose yes
zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history
zstyle ':completion:*:messages' format '%F{YELLOW}%d'$DEFAULT
zstyle ':completion:*:warnings' format '%F{RED}No matches for:''%F{YELLOW} %d'$DEFAULT
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:descriptions' format '%F{yellow}Completing %B%d%b%f'$DEFAULT
zstyle ':completion:*' group-name ''
zstyle ':completion:*:*:*:*:*' menu select interactive
setopt menu_complete
setopt nolistbeep

if [ -f /usr/local/share/zsh/site-functions/_git ]; then
  echo "zsh built-in git completion is overridden."
  rm -i /usr/local/share/zsh/site-functions/_git
fi

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=251"

bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^F' forward-char
bindkey '^B' backward-char

############
## fzfの設定
export MANPATH="\$MANPATH:$HOME/.zplug/repos/junegunn/fzf/man"
export FZF_DEFAULT_OPTS="--reverse --inline-info --ansi
  --bind ctrl-f:page-down,ctrl-b:page-up
  --color bg+:007,fg+:010,hl:009,hl+:009"
zstyle ':anyframe:selector:fzf:' command fzf-tmux
# fzfの関数
anyframe-widget-z() {
  z -l | sed 's/^[0-9,.]* *//' | sed s"#$HOME#~#" \
    | fzf-tmux --tac +s \
    | anyframe-action-execute cd
}
zle -N anyframe-widget-z
bindkey '^@' anyframe-widget-z
v() {
  local files
  files=$(grep '^>' ~/.viminfo | cut -c3- | grep -v ".git/COMMIT_EDITMSG" |
    while read line; do
      [ -f "${line/\~/$HOME}" ] && echo "$line"
    done | fzf-tmux -d -m -q "$*" -1) && vim ${files//\~/$HOME}
}

############
## agnosterテーマの設定
# 通常時はHost名とユーザー名を表示しない
export DEFAULT_USER=ryota
# PowerLineパッチの当たっていないフォント用
#export SEGMENT_SEPARATOR='⮀'
# PowerLineのセパレータをtmux.confで取得できるようにする
export SEGMENT_SEPARATOR=$SEGMENT_SEPARATOR

############
## 速度測定
# 無効にする場合は~/.zshenvのzmodload zsh/zprof && zprofをコメントアウト
if (which zprof > /dev/null) ;then
  zprof | less
fi
