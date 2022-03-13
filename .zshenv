# /etc/zsh/zshrcでcompinitが呼ばれないようにする
skip_global_compinit=1

export PATH="/usr/local/bin:$PATH"
if [ -f /opt/homebrew/bin/brew ]; then
  eval $(/opt/homebrew/bin/brew shellenv)
  export PATH="/opt/homebrew/opt/python/libexec/bin:$PATH"
fi

# Profile
#zmodload zsh/zprof && zprof
