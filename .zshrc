# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

if [[ "$LC_TERMINAL" = "ShellFish" ]]; then
    exec fish --login
fi

############
## PATH設定

############
## WSL
if [ -e /proc/version ] && grep -q Microsoft /proc/version; then
  unsetopt BG_NICE # for WSL 1803
fi

############
## zinit
if [ ! -f ~/.zinit/bin/zinit.zsh ]; then
  printf "Install zinit? [y/N]: "
  if read -q; then
    echo; sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"
  fi
fi

### Added by zinit's installer
source ~/.zinit/bin/zinit.zsh
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of zinit's installer chunk

zinit ice pick"async.zsh" src"pure.zsh"
zinit light sindresorhus/pure

zinit snippet PZT::modules/terminal/init.zsh
zinit snippet PZT::modules/history/init.zsh

zinit ice atclone'git clone https://github.com/zsh-users/zsh-history-substring-search.git external'
zinit snippet PZT::modules/history-substring-search/init.zsh

zinit ice wait lucid;
zinit snippet PZT::modules/utility/init.zsh

zinit ice wait lucid
zinit snippet OMZ::lib/git.zsh

zinit ice wait lucid
zinit snippet OMZ::plugins/git/git.plugin.zsh

zinit ice wait lucid
zinit light momo-lab/zsh-abbrev-alias

zinit ice wait lucid
zinit light agkozak/zsh-z
export ZSHZ_CMD=j

zinit ice wait blockf lucid
zinit light zsh-users/zsh-completions

zinit ice wait atload"_zsh_autosuggest_start" lucid
zinit light zsh-users/zsh-autosuggestions

zinit ice wait lucid
zinit light zdharma/fast-syntax-highlighting

zinit ice wait lucid
zinit snippet PZT::modules/completion/init.zsh

############
## Profile
# 無効にする場合は~/.zshenvのzmodload zsh/zprof && zprofをコメントアウト
if (which zprof > /dev/null) ;then
  zprof | less
fi
