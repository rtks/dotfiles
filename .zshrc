############
## PATH設定

############
## WSL
if grep -q Microsoft /proc/version; then
  unsetopt BG_NICE # for WSL 1803
fi

############
## zplugin
if [ ! -f ~/.zplugin/bin/zplugin.zsh ]; then
  printf "Install zplugin? [y/N]: "
  if read -q; then
    echo; sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zplugin/master/doc/install.sh)"
  fi
fi

### Added by Zplugin's installer
source ~/.zplugin/bin/zplugin.zsh
autoload -Uz _zplugin
### End of Zplugin's installer chunk

zplugin ice pick"async.zsh" src"pure.zsh"
zplugin light sindresorhus/pure

zplugin snippet PZT::modules/terminal/init.zsh
zplugin snippet PZT::modules/history/init.zsh

zplugin ice atclone'git clone https://github.com/zsh-users/zsh-history-substring-search.git external'
zplugin snippet PZT::modules/history-substring-search/init.zsh

zplugin ice wait lucid;
zplugin snippet PZT::modules/utility/init.zsh

zplugin ice wait lucid
zplugin snippet OMZ::lib/git.zsh

zplugin ice wait lucid
zplugin snippet OMZ::plugins/git/git.plugin.zsh

zplugin ice wait lucid
zplugin light momo-lab/zsh-abbrev-alias

zplugin ice wait lucid
zplugin light agkozak/zsh-z
export ZSHZ_CMD=j

zplugin ice wait blockf lucid
zplugin light zsh-users/zsh-completions

zplugin ice wait atload"_zsh_autosuggest_start" lucid
zplugin light zsh-users/zsh-autosuggestions

zplugin ice wait lucid
zplugin light zdharma/fast-syntax-highlighting

zplugin ice wait lucid
zplugin snippet PZT::modules/completion/init.zsh

############
## Profile
# 無効にする場合は~/.zshenvのzmodload zsh/zprof && zprofをコメントアウト
if (which zprof > /dev/null) ;then
  zprof | less
fi
