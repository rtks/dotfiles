function delete-or-deactivate-or-exit
  if [ -z (commandline) ]
    if set -q VIRTUAL_ENV; and type -q deactivate
      builtin commandline -a deactivate
      builtin commandline -f execute
    else
      builtin exit
    end
  else
    builtin commandline -f delete-char
  end
end
