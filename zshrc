# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="agnoster"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git osx brew brew-cask sublime atom common-aliases)

##############################################
# User configuration

# 通常時はHost名とユーザー名を表示しない
export DEFAULT_USER=ryota
# 日本語
setopt print_eight_bit # 補完候補リストの日本語を正しく表示
# History
setopt share_history # Historyを共有
setopt inc_append_history # コマンド実行時にHistoryに追記
setopt hist_ignore_all_dups  # 重複したHistoryは追加しない
setopt hist_find_no_dups # History検索中に重複を飛ばす
setopt HIST_IGNORE_SPACE # 余分な空白は詰めて記録
setopt hist_reduce_blanks # 冗長な空白を除く

setopt combining_chars

#補完リストが多いときに尋ねない
LISTMAX=1000

#lessコマンドなどで色をつける
export CLICOLOR_FORCE=1

export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin"

export GNUTERM=x11
export PATH="/opt/X11/bin:$PATH"

export PATH="/Library/TeX/texbin:$PATH"

export NODE_PATH=$HOME/nodebrew/current/lib/node_modules
export PATH="$HOME/nodebrew/current/bin:$PATH"

export PATH="$HOME/pyenv/bin:$PATH"

export PATH="$HOME/work/hrp2/gcc-arm-none-eabi-4_9-2015q1/bin:$PATH"

export PATH="$HOME/Developer/android-sdk-macosx/tools:$PATH"

#export PATH="~/Library/Python/2.7/bin:$PATH"
#export PATH=/usr/local/share/python:$PATH
#source `which virtualenvwrapper.sh`
#export PYTHONPATH=/usr/local/lib/python2.7/site-packages:$PYTHONPATH

#export iOSOpenDevPath=/opt/iOSOpenDev
#export iOSOpenDevDevice=
#export PATH=/opt/iOSOpenDev/bin:$PATH

##############################################

# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8
export LANG=ja_JP.UTF-8
export LC_CTYPE=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

##############################################
# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# グローバルエイリアス
alias -g C='| pbcopy' # C で標準出力をクリップボードにコピーする(Mac)

alias reload_shell='exec $SHELL'
alias platex='platex --kanji=utf8'
alias nf=terminal-notifier
alias more='more -R'

###############
# Themeの調整
# SEPARATORをズレが小さい文字に置き換え
export SEGMENT_SEPARATOR='⮀'
# プロンプトの色を変更する 
prompt_dir() {
  prompt_segment white default '%.'
}
prompt_context() {
  local user=`whoami`
  if [[ "$user" != "$DEFAULT_USER" || -n "$SSH_CONNECTION" ]]; then
    prompt_segment cyan black "%(!.%{%F{yellow}%}.)$user@%m"
  fi
}

# cdrの設定 最近使ったディレクトリを補完
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
zstyle ':chpwd:*' recent-dirs-max 500 # cdrの履歴を保存する個数
zstyle ':chpwd:*' recent-dirs-default yes
zstyle ':completion:*' recent-dirs-insert both
# zawを読み込む
source ~/.zaw/zaw.zsh
# zawの設定 Case insensitiveにする
zstyle ':filter-select' case-insensitive yes
# zawのキーバインド
bindkey '^@' zaw-cdr
bindkey '^R' zaw-history
bindkey '^X^F' zaw-git-files
bindkey '^X^B' zaw-git-branches
bindkey '^X^P' zaw-process
#bindkey '^A' zaw-tmux

# 速度測定 無効にする場合は~/.zshenvのzmodload zsh/zprof && zprofをコメントアウト
if (which zprof > /dev/null) ;then
  zprof | less
fi
