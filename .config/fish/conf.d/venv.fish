function __auto_source_venv --on-variable PWD --description "Activate/Deactivate virtualenv on directory change"
  status --is-command-substitution; and return

  # Check if we are inside a git directory
  if git rev-parse --show-toplevel &>/dev/null
    set gitdir (realpath (git rev-parse --show-toplevel))
  else
    set gitdir ''
  end

  # find a virtual environment
  set dir (string replace "$gitdir" '' -- $PWD)
  set VENV_DIR_NAMES env .env venv .venv
  while true
    for venv_dir in $gitdir$dir/$VENV_DIR_NAMES
      if test -e "$venv_dir/bin/activate.fish"
        if test "$VIRTUAL_ENV" != "$venv_dir"
          source $venv_dir/bin/activate.fish
        end
		return
      end
    end
    set dir (string replace -r '/[^/]*$' '' -- $dir)
    test -z "$dir"; and break
  end
  # If venv activated but the current (git) dir has no venv.
  if test -n "$VIRTUAL_ENV"; and functions -q deactivate
    deactivate
  end
end
