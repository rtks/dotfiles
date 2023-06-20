if [ -d "$HOME/.pyenv" ]
  set -gx PYENV_ROOT "$HOME/.pyenv"
  set -p PATH "$PYENV_ROOT/bin"
  pyenv init - | source
end

