############
## PATH設定

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
(( ${+_comps} )) && _comps[zplugin]=_zplugin
### End of Zplugin's installer chunk

zplugin ice pick"async.zsh" src"pure.zsh"
zplugin light sindresorhus/pure

zplugin snippet PZT::modules/terminal/init.zsh
zplugin snippet PZT::modules/history/init.zsh

zplugin ice svn atclone'git clone https://github.com/zsh-users/zsh-history-substring-search.git external'
zplugin snippet PZT::modules/history-substring-search

zplugin ice wait svn lucid;
zplugin snippet PZT::modules/utility

zplugin ice wait lucid
zplugin snippet OMZ::lib/git.zsh

zplugin ice wait lucid
zplugin snippet OMZ::plugins/git/git.plugin.zsh

zplugin ice wait lucid
zplugin light momo-lab/zsh-abbrev-alias

zplugin ice wait blockf lucid
zplugin light zsh-users/zsh-completions

zplugin ice wait atload"_zsh_autosuggest_start" lucid
zplugin light zsh-users/zsh-autosuggestions

zplugin ice wait lucid
zplugin light zdharma/fast-syntax-highlighting

zplugin ice wait lucid
zplugin snippet PZT::modules/completion/init.zsh

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
## 速度測定
# 無効にする場合は~/.zshenvのzmodload zsh/zprof && zprofをコメントアウト
if (which zprof > /dev/null) ;then
  zprof | less
fi
