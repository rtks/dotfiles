set --global __fish_prompt_result __fish_prompt_result_$fish_pid

function __fish_prompt_repaint --on-signal USR1
  if set -q __fish_prompt_queued
    commandline --function repaint
  end
end

function __fish_prompt_exit --on-event fish_exit
  set -q $__fish_prompt_result && set -e $__fish_prompt_result
  for i in (set -Un | string match -r '^__fish_prompt_result_\d+$')
    if not kill -s 0 (string match -r '\d+$' $i) &>/dev/null
      set -e $i
    end
  end
end

if not type -q starship

  function fish_prompt --description 'Write out the prompt'
    set -l last_pipestatus $pipestatus

    if contains PWD $__fish_prompt_trigger
      set -l git_root (command git --no-optional-locks rev-parse --show-toplevel 2>/dev/null)

      if set --query git_root[1]
        if [ "$git_root[1]" != "$__fish_prompt_git_root" ]
          set -g __fish_prompt_git_info ' (…)'
          set -g __fish_prompt_git_root $git_root[1]
        end
      else
        set -e __fish_prompt_git_root
      end

      set -l git_base (string replace --all --regex -- "^.*/" "" "$git_root")
      set -g __fish_prompt_pwd (
        string replace --ignore-case -- ~ \~ $PWD |
        string replace -- "/$git_base/" /:/ |
        string replace --regex --all -- "(\.?[^/]{1})[^/]*/" "\$1/" |
        string replace -- : "$git_base"
      )
    end

    if set -q __fish_prompt_git_root
      if set -q __fish_prompt_queued
        for i in (seq 100)
          if set -q $__fish_prompt_result
            break
          end
          sleep 0.01
        end
        set -g __fish_prompt_git_info $$__fish_prompt_result
        set -e $__fish_prompt_result
        set -e __fish_prompt_queued
      else
        set -g __fish_prompt_queued
        set __fish_prompt_git_info (set_color $fish_color_autosuggestion; string replace -r -a '\\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]' '' $__fish_prompt_git_info)
        fish -P -c "
          set -x GIT_OPTIONAL_LOCKS 0
          set __fish_git_prompt_show_informative_status 'yes'
          set __fish_git_prompt_showcolorhints 'yes'
          set __fish_git_prompt_showstashstate 'yes'
          set __fish_git_prompt_showuntrackedfiles 'yes'
          set __fish_git_prompt_char_cleanstate '✓'
          set __fish_git_prompt_char_dirtystate '+'
          set __fish_git_prompt_char_invalidstate '×'
          set __fish_git_prompt_char_stagedstate '✓'
          set __fish_git_prompt_char_stashstate '≡'
          set __fish_git_prompt_char_untrackedfiles '…'
          set __fish_git_prompt_char_upstream_ahead '⤴'
          set __fish_git_prompt_char_upstream_behind '⤵'
          set -U $__fish_prompt_result (fish_git_prompt)
          kill -s USR1 $fish_pid 2>/dev/null
          for i in (seq 10)
            if not set -q $__fish_prompt_result
              break
            end
            sleep 0.1
            kill -s USR1 $fish_pid 2>/dev/null
          end" &
        disown
      end
    else
      set -g __fish_prompt_git_info ''
    end

    __fish_prompt_extra

    # Hostname
    if set -q SSH_CONNECTED; or set -q SSH_CONNECTION
      if not set -q TMUX; and not set -q VSCODE_SHELL_INTEGRATION
        echo -n (prompt_hostname)' '
      end
    end

    # PWD
    set_color $fish_color_cwd
    if not test -w .
      echo -n ''
    end
    echo -n $__fish_prompt_pwd
    set_color normal

    # Git
    echo -n $__fish_prompt_git_info
    echo -n ' '

    # Duration
    set -l duration $CMD_DURATION
    if test $duration -ge 5000
      set -l ss (math -s0 $duration / 10 % 100)
      set -l s (math -s0 $duration / 1000 % 60)
      set -l m (math -s0 $duration / 60000 % 60)
      set -l h (math -s0 $duration / 3600000 % 24)
      set -l d (math -s0 $duration / 86400000)
      set_color yellow
      if test $d -gt 0
        echo -sn $d "d"
      end
      if test $h -gt 0
        echo -sn $h "h"
      end
      if test $m -gt 0
        echo -sn $m "m"
      end
      if test $duration -ge 3600000
        echo -sn $s "s "
      else
        printf '%d.%02ds ' $s $ss
      end
    end
    set_color normal

    # Job Count
    set -l job_count (count (jobs))
    if test $job_count -gt 0
      echo -n "+"$job_count" "
    end

    # Exit code
    for i in $last_pipestatus
      if test $i -ne 0
        set_color $fish_color_error
        if [ (count $last_pipestatus) -eq 1 ]
          switch $last_pipestatus
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
              echo -n $last_pipestatus
          end
        else
          echo -n $last_pipestatus
        end
        break
      end
    end

    echo -n '> '
    set_color normal
  end

  function __fish_prompt_pwd_changed --on-variable PWD
    set -ga __fish_prompt_trigger PWD
  end

  __fish_prompt_pwd_changed

  function __fish_prompt_path_changed --on-variable PATH
    set -ga __fish_prompt_trigger PATH
  end

  function __fish_prompt_preexec --on-event fish_preexec
    set -e __fish_prompt_trigger
  end

  function __fish_prompt_extra
    if ! set -q __fish_prompt_trigger
      return
    end

    set -l line ''

    # Current Git author
    if command git --no-optional-locks rev-parse 2>/dev/null
      set line $line(set_color yellow)
      set line $line"Git "
      set line $line(set_color normal)
      set line $line(command git --no-optional-locks config user.name)" <"(command git --no-optional-locks config user.email)"> "
      function __fish_prompt_pwd_get
        echo (ls {$__fish_prompt_git_root,./}/$argv[1] 2>/dev/null)[1]
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
    begin
      type -q python
      or type -q python3
    end
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
      if type -q python
        set line $line(python --version 2>&1 | string replace "Python " "")
      else
        set line $line(python3 --version 2>&1 | string replace "Python " "")
      end
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

    if [ -z "$line" ]
      return
    end

    echo $line
    set_color normal
  end

else

  starship init --print-full-init fish | source
  function starship_transient_prompt_func
    echo -n '> '
  end
  #enable_transience
  functions -c fish_prompt fish_prompt_starship
  functions -e fish_prompt
  functions -e fish_right_prompt

  function __fish_prompt_cmd_finished --on-event fish_postexec
    set -g STARSHIP_CMD_PIPESTATUS $pipestatus
    set -g STARSHIP_CMD_STATUS $status
  end

  function fish_prompt --description 'Write out the prompt'
    switch "$fish_key_bindings"
        case fish_hybrid_key_bindings fish_vi_key_bindings
            set STARSHIP_KEYMAP "$fish_bind_mode"
        case '*'
            set STARSHIP_KEYMAP insert
    end
    # Account for changes in variable name between v2.7 and v3.0
    set STARSHIP_DURATION "$CMD_DURATION$cmd_duration"
    set STARSHIP_JOBS (count (jobs -p))

    if test "$TRANSIENT" = "1"
      fish_prompt_starship
      return
    end

    if contains PWD $__fish_prompt_trigger
      set -l git_root (command git --no-optional-locks rev-parse --show-toplevel 2>/dev/null)
      if set --query git_root[1]
        if [ "$git_root[1]" != "$__fish_prompt_git_root" ]
          set -g __fish_prompt_git_info '…'
          set -g __fish_prompt_git_root $git_root[1]
        end
      else
        set -e __fish_prompt_git_root
      end
    end

    set -lx FISH_PROMPT_GIT ''
    if set -q __fish_prompt_git_root
      if set -q __fish_prompt_queued
        for i in (seq 100)
          if set -q $__fish_prompt_result
            break
          end
          sleep 0.01
        end
        set -g __fish_prompt_git_info $$__fish_prompt_result
        set -e $__fish_prompt_result
        set -e __fish_prompt_queued
      else
        set -g __fish_prompt_queued 1
        set __fish_prompt_git_info (set_color $fish_color_autosuggestion; string replace -r -a '\\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]' '' $__fish_prompt_git_info)
        fish -P -c "
          set -U $__fish_prompt_result (STARSHIP_CONFIG=~/.config/starship_git.toml starship prompt)
          kill -s USR1 $fish_pid 2>/dev/null
          for i in (seq 10)
            if not set -q $__fish_prompt_result
              break
            end
            sleep 0.1
            kill -s USR1 $fish_pid 2>/dev/null
          end" &
        disown
      end
      set FISH_PROMPT_GIT $__fish_prompt_git_info
    else
      set -e FISH_PROMPT_GIT
    end

    set -lx FISH_PROMPT_EXTRA ''
    if set -q __fish_prompt_trigger
      set FISH_PROMPT_EXTRA (STARSHIP_CONFIG=~/.config/starship_extra.toml starship prompt | sed "s/\x1B\[J//")
    end
    if test -z "$FISH_PROMPT_EXTRA"
      set -e FISH_PROMPT_EXTRA
    end
    starship prompt --terminal-width="$COLUMNS" --status=$STARSHIP_CMD_STATUS --pipestatus="$STARSHIP_CMD_PIPESTATUS" --keymap=$STARSHIP_KEYMAP --cmd-duration=$STARSHIP_DURATION --jobs=$STARSHIP_JOBS
  end

  function __fish_prompt_pwd_changed --on-variable PWD
    set -ga __fish_prompt_trigger PWD
  end

  __fish_prompt_pwd_changed

  function __fish_prompt_path_changed --on-variable PATH
    set -ga __fish_prompt_trigger PATH
  end

  function __fish_prompt_preexec --on-event fish_preexec
    set -e __fish_prompt_trigger
  end
end
