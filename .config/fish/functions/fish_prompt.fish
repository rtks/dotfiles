function fish_prompt --description 'Write out the prompt'
  set -l last_status $status
  
  # Hostname
  if set -q SSH_CONNECTED; or set -q SSH_CONNECTION
    echo -n (prompt_hostname)' '
  end

  # PWD
  set_color $fish_color_cwd
  if not test -w .
    echo -n ''
  end
  echo -n (prompt_pwd)' '
  set_color normal

  # Git
  __fish_git_prompt '(%s) '

  # Job
  set -l jobcount (count (jobs)) 
  if test $jobcount -gt 0
    echo -n '▶'$jobcount' '
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

# Fish git prompt
set __fish_git_prompt_show_informative_status 'yes'
set __fish_git_prompt_showcolorhints 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_char_cleanstate '✓'
set __fish_git_prompt_char_dirtystate '↔'
set __fish_git_prompt_char_invalidstate '×'
set __fish_git_prompt_char_stagedstate '✓'
set __fish_git_prompt_char_stashstate '■'
set __fish_git_prompt_char_untrackedfiles '…'
set __fish_git_prompt_char_upstream_ahead '⤴'
set __fish_git_prompt_char_upstream_behind '⤵'
set __fish_git_prompt_color_stashstate cyan
