############
## PATH設定

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

zplugin ice wait"0" blockf lucid
zplugin light zsh-users/zsh-completions

zplugin ice wait"0" atload"_zsh_autosuggest_start" lucid
zplugin light zsh-users/zsh-autosuggestions

zplugin ice wait"0" atinit"zpcompinit; zpcdreplay" lucid
zplugin light zdharma/fast-syntax-highlighting

zplugin ice wait"0" lucid
zplugin snippet OMZ::lib/git.zsh

zplugin ice wait"0" atload"unalias grv" lucid
zplugin snippet OMZ::plugins/git/git.plugin.zsh

setopt promptsubst
zplugin snippet OMZ::themes/agnoster.zsh-theme

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

bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^F' forward-char
bindkey '^B' backward-char

export DEFAULT_USER=ryota

############
## 速度測定
# 無効にする場合は~/.zshenvのzmodload zsh/zprof && zprofをコメントアウト
if (which zprof > /dev/null) ;then
  zprof | less
fi
