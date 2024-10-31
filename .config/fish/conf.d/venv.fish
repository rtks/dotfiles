if not status is-interactive
  exit
end

function __auto_source_venv --on-variable PWD --description "Activate/Deactivate virtualenv on directory change"
  status --is-command-substitution; and return

  # Check if we are inside a git directory
  if git rev-parse --show-toplevel &>/dev/null
    set gitdir (realpath (git rev-parse --show-toplevel))
  else
    set gitdir ''
  end

  # find a virtual environment
  set dir (pwd)
  set VENV_DIR_NAMES env .env venv .venv
  while test $dir != /
    for venv_dir in $dir/$VENV_DIR_NAMES
      if test -d $venv_dir
        if test "$VIRTUAL_ENV" != $venv_dir
          for venv_activate in $venv_dir/{bin,Scripts}/activate.fish
            if test -e $venv_activate
              source $venv_activate
            end
          end
        end
		return
      end
    end
    set dir (path dirname $dir)
  end
  # If venv activated but the current (git) dir has no venv.
  if test -n "$VIRTUAL_ENV"; and functions -q deactivate
    deactivate
  end
end
