function __fish_prompt_setup_on_startup --on-event fish_prompt
  functions -e (status current-function)
  set -g __fish_prompt_result (__git_informative_prompt)
end

function fish_prompt --description 'Write out the prompt'
  set -l last_status $status

  if not set -q __fish_prompt_result
    set __fish_prompt_git_info (set_color brcyan;string replace -r -a '\\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]' '' $__fish_prompt_git_info)
    __run_async __git_informative_prompt __fish_prompt_callback
  else
    set -g __fish_prompt_git_info $__fish_prompt_result
    set -e __fish_prompt_result
  end
  set -e __fish_prompt_pwd_out

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

  # Job Count
  set -l job_count (count (jobs -p))
  if test $job_count -gt 0
    echo -n "+"$job_count" "
  end

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

function __fish_prompt_pwd --on-variable PWD --on-variable PATH
  set -g __fish_prompt_git_info ''

  set -q __fish_prompt_pwd_out; and return 
  set -g __fish_prompt_pwd_out 1

  set -l line ""

  # Current Git author
  if command git rev-parse 2>/dev/null
    set line $line(set_color yellow)
    set line $line"Git "
    set line $line(set_color normal)
    set line $line(git config user.name)" <"(git config user.email)"> "
    function __fish_prompt_pwd_get
      echo (ls {(git rev-parse --show-toplevel),./}/$argv[1] 2>/dev/null)[1]
    end
  else
    function __fish_prompt_pwd_get
      echo $argv[1]
    end
  end

  # Current Rust version
  type -q rustc
  and begin 
    test -f (__fish_prompt_pwd_get Cargo.toml)
    or test (count *.rs) -gt 0 
  end
  and begin
    set line $line(set_color yellow)
    set line $line"Rust "
    set line $line(set_color normal)
    set line $line(echo (string split "(" -- (rustc --version))[1] | string replace "rustc " "")
  end

  # Current Python version
  type -q python
  and begin
    set -q VIRTUAL_ENV
    or test -f requirements.txt
    or test -f .python-version
    or test -f pyproject.toml
    or test -f Pipfile
    or test (count *.py) -gt 0
  end
  and begin
    set line $line(set_color yellow)
    set line $line"Python "
    set line $line(set_color normal)
    set line $line(python --version 2>&1 | string replace "Python " "")
  end
  
  # Current version of package in current directory
  type -q cargo
  and test -f (__fish_prompt_pwd_get Cargo.toml)
  and set -l package_ver (string trim -c "'\" " (string split = (cat (__fish_prompt_pwd_get Cargo.toml) | string match -r "version\s*=.*")[1] | string split =)[-1])
  and test -n "$package_ver"
  and begin
    set line $line(set_color yellow)
    set line $line"Package "
    set line $line(set_color normal)
    set line $line$package_ver
  end

  test -n "$line"; and echo "$line"
  set_color normal
end
