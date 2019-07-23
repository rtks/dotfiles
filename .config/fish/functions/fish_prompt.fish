set __fish_prompt_initialize 1

function fish_prompt --description 'Write out the prompt'
  set -l last_status $status

  if set -q __fish_prompt_initialize
    set -g __fish_prompt_git_info (__git_informative_prompt)
    set -e __fish_prompt_initialize
  else
    if not set -q __fish_prompt_result
      __run_async fish_prompt_async __fish_prompt_callback __git_informative_prompt
    else
      set -g __fish_prompt_git_info $__fish_prompt_result
      set -e __fish_prompt_result
    end
  end

  # Hostname
  if set -q SSH_CONNECTED; or set -q SSH_CONNECTION
    echo -n (prompt_hostname)' '
  end

  # PWD
  set_color $fish_color_cwd
  if not test -w .
    echo -n ''
  end
  echo -n (prompt_pwd)
  set_color normal

  # Git
  echo -n $__fish_prompt_git_info
  echo -n ' '

  # Duration
  set -l duration $CMD_DURATION
  if test $duration -ge 5000
    set -l ms (math -s0 $duration % 1000 / 10)
    set -l s (math -s0 $duration / 1000 % 60)
    set -l m (math -s0 $duration / 60000 % 60)
    set -l h (math -s0 $duration / 3600000 % 24)
    set_color yellow
    if test $h -gt 0
        echo -sn $h "h"
    end
    if test $m -gt 0
        echo -sn $m "m"
    end
    echo -sn $s.$ms "s "
  end
  set_color normal

  # Exit code
  if not test $last_status -eq 0
    set_color $fish_color_error
    switch $last_status
      case 1
        echo -n "ERROR"
      case 2
        echo -n "USAGE"
      case 126
        echo -n "NOPERM"
      case 127
        echo -n "NOTFOUND"
      case 128 + 1
        echo -n "SIGHUP"
      case 128 + 2
        echo -n "SIGINT"
      case 128 + 3
        echo -n "SIGQUIT"
      case 128 + 4
        echo -n "SIGILL"
      case 128 + 5
        echo -n "SIGTRAP"
      case 128 + 6
        echo -n "SIGIOT"
      case 128 + 7
        echo -n "SIGBUS"
      case 128 + 8
        echo -n "SIGFPE"
      case 128 + 9
        echo -n "SIGKILL"
      case 128 + 10
        echo -n "SIGUSR1"
      case 128 + 11
        echo -n "SIGSEGV"
      case 128 + 12
        echo -n "SIGUSR2"
      case 128 + 13
        echo -n "SIGPIPE"
      case 128 + 14
        echo -n "SIGALRM"
      case 128 + 15
        echo -n "SIGTERM"
      case 128 + 16
        echo -n "SIGSTKFLT"
      case 128 + 17
        echo -n "SIGCHLD"
      case 128 + 18
        echo -n "SIGCONT"
      case 128 + 19
        echo -n "SIGSTOP"
      case 128 + 20
        echo -n "SIGTSTP"
      case 128 + 21
        echo -n "SIGTTIN"
      case 128 + 22
        echo -n "SIGTTOU"
      case '*'
        echo -n $last_status
    end
  end
  echo -n '> '
  set_color normal
end

function __fish_prompt_callback
  set -g __fish_prompt_result $argv[1]
  __fish_prompt_refresh
end

function __fish_prompt_refresh
  fish -c "kill -WINCH $fish_pid" 2>/dev/null &
  set -l pid (jobs --last --pid)
  disown $pid  # prevent blocking exit while job is running
end

function __fish_prompt_pwd --on-variable PWD
  set -g __fish_prompt_git_info ''
end
